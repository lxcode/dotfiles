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
vis:map(vis.modes.NORMAL, ';', ':')
vis:map(vis.modes.NORMAL, 'Q', ':q!<Enter>')
vis:map(vis.modes.NORMAL, '<C-e>', ':fzf<Enter>')
vis:map(vis.modes.NORMAL, ',m', ':fzfmru<Enter>')
vis:map(vis.modes.NORMAL, '~', 'g~')
vis:map(vis.modes.NORMAL, 'zz', 'ZZ')
vis:map(vis.modes.VISUAL, 'gy', '"+y')
end)

-- builtin plugins
require('plugins/complete-filename')
require('plugins/complete-word')
require('plugins/filetype')
require('plugins/number-inc-dec')

-- local plugins

local plug = require('plugins/vis-plug')

-- configure plugins in an array of tables with git urls and options
local plugins = {

	{ 'kupospelov/vis-ctags' },
	{ 'erf/vis-sneak' },
	{ 'peaceant/vis-fzf-mru' },
	{ 'https://git.sr.ht/~mcepl/vis-fzf-open' },
	{ 'https://gitlab.com/muhq/vis-spellcheck' },
	{ 'https://repo.or.cz/vis-quickfix.git' },
}

-- require and optionally install plugins on init
plug.init(plugins, true)
