-- load standard vis module, providing parts of the Lua API
require('vis')

vis.events.subscribe(vis.events.INIT, function()
vis:command('set theme base16-onedark')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	-- Your per window configuration options e.g.
vis:command('set tabwidth 4')
vis:command('set autoindent')
vis:command('set expandtab')
vis:command('set cursorline')
vis:command('set number')
vis:command('map! normal ; :')
vis:command('map! normal zz ZZ')
vis:command('map! normal <C-e> :fzf<Enter>')
vis:command('map! normal ,m :fzfmru<Enter>')
end)

-- builtin plugins
require('plugins/complete-filename')
require('plugins/complete-word')
require('plugins/filetype')
require('plugins/number-inc-dec')

-- local plugins
plugin_vis_open =require('plugins/vis-fzf-open/fzf-open')
require('plugins/vis-ctags/ctags')
--require('plugins/vis-cursors/cursors')
