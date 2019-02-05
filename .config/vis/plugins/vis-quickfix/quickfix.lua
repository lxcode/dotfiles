require("vis")
local vis = vis

local M

local W = {}

local format

local function match_valid(l)
	if format then
		return l:match(format)
	end
	local filename, line, col = l:match(M.errorformat)
	if not (filename and line) then
		filename, line = l:match(M.grepformat)
	end
	return filename, line, col
end

local function setup(win)
	local ccur = 0
	local cline = 1

	local function only()
		for w in vis:windows() do
			if w ~= win then
				w:close()
			end
		end
	end

	local function cc(quickfix, upto)
		quickfix = quickfix < 1 and 1 or quickfix
		local i, j = 0, 0
		local filename, line, col
		local last_valid
		for l in win.file:lines_iterator() do
			i = i + 1
			if match_valid(l) then
				last_valid = i
				filename, line, col = match_valid(l)
				j = j + 1
				if j == quickfix or upto and i >= upto then
					break
				end
			end
		end
		if filename and line then
			only()
			ccur = j
			cline = last_valid
			win.selection:to(cline, 1)
			vis:command(string.format("open %q", filename))
			vis.win.selection:to(line, col or 1)
		end
	end

	win:map(vis.modes.NORMAL, "<Enter>", function()
		cc(#win.file.lines, win.selection.line)
	end)

	W.cc = function(argv)
		cc((#argv > 0 and tonumber(argv[1])) or ccur)
	end

	W.cnext = function(argv)
		local inc = #argv > 0 and tonumber(argv[1]) or 1
		cc(ccur + inc)
	end

	W.cprev = function(argv)
		local dec = #argv > 0 and tonumber(argv[1]) or 1
		cc(ccur - dec)
	end

	W.crewind = function()
		cc(1)
	end

	W.clast = function()
		cc(#win.file.lines)
	end

	W.cnfile = function()
		local cur_fname = match_valid(win.file.lines[cline])
		local clast = #win.file.lines
		local j = 0
		for i = cline + 1, clast do
			local filename = match_valid(win.file.lines[i])
			if filename then
				j = j + 1
				if filename ~= cur_fname then
					cc(ccur + j)
					break
				end
			end
		end
	end

	W.cpfile = function()
		local cur_fname = match_valid(win.file.lines[cline])
		local cfirst = 1
		local j = 0
		for i = cline - 1, cfirst, -1 do
			local filename = match_valid(win.file.lines[i])
			if filename then
				j = j + 1
				if filename ~= cur_fname then
					cc(ccur - j)
					break
				end
			end
		end
	end

end

vis:command_register("cc", function(...)
	if W.cc then W.cc(...) end
end)

vis:command_register("cn", function(...)
	if W.cnext then W.cnext(...) end
end)

vis:command_register("cp", function(...)
	if W.cprev then W.cprev(...) end
end)

vis:command_register("cr", function(...)
	if W.crewind then W.crewind(...) end
end)

vis:command_register("cla", function(...)
	if W.clast then W.clast(...) end
end)

vis:command_register("cnf", function(...)
	if W.cnfile then W.cnfile(...) end
end)

vis:command_register("cpf", function(...)
	if W.cpfile then W.cpfile(...) end
end)

vis:command_register("cf", function(argv, force, win, selection, range)
	if #argv > 0 then M.errorfile = argv[1] end
	vis:command(string.format("%s %s", (win.file.modified and "open" or "e"), M.errorfile))
	format = nil
	setup(vis.win)
	W.crewind(argv, force, win, selection, range)
end)

local function cexpr(argv, force, win, selection, range)
	if #argv == 0 then vis:info"Failed to detect command" return end
	local code, stdout, stderr = vis:pipe(win.file, {start = 0, finish = 0}, table.concat(argv, " "))
	if stdout then
		vis:command(string.format("open %s", M.errorfile))
		vis.win.file:delete(0, vis.win.file.size)
		vis.win.file:insert(0, format == M.errorformat and stderr or stdout)
		setup(vis.win)
		W.crewind(argv, force, win, selection, range)
	elseif code ~= 0 and stderr then
		vis:message(stderr)
	end
end

vis:command_register("cex", cexpr)

vis:command_register("grep", function(argv, force, win, selection, range)
	for i, arg in ipairs(M.grepprg) do
		table.insert(argv, i, arg)
	end
	format = M.grepformat
	cexpr(argv, force, win, selection, range)
end)

vis:command_register("make", function(argv, force, win, selection, range)
	for i, arg in ipairs(M.makeprg) do
		table.insert(argv, i, arg)
	end
	format = M.errorformat
	cexpr(argv, force, win, selection, range)
end)

M = {
	grepformat = '^"?([^:"\n]+)"?' .. ":(%d+):[^%d].+$",
	errorformat = '^"?([^:"\n]+)"?' .. ":(%d+):(%d+):.+$",
	grepprg = {"grep", "-n"},
	makeprg = {"make", "-s"},
	errorfile = "errors.err",
}

return M
