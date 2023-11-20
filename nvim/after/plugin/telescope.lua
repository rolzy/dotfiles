local utils = require('telescope.utils')
local builtin = require('telescope.builtin')
_G.project_files = function()
    local _, ret, _ = utils.get_os_command_output({ 'git', 'rev-parse', '--is-inside-work-tree' }) 
    if ret == 0 then 
        builtin.git_files() 
    else
        builtin.find_files()
    end 
end 
vim.keymap.set('n', '<C-p>', builtin.find_files, {noremap=true})
vim.keymap.set('n', '<C-g>', builtin.live_grep, {})
