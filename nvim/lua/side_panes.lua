-- Winbar
local get_hex = require('cokeline/hlgroups').get_hl_attr
require('cokeline').setup({
    default_hl = {
        fg = function(buffer)
            return
                buffer.is_focused
                and get_hex('ColorColumn', 'bg')
                or get_hex('Normal', 'fg')
        end,
        bg = function(buffer)
            return
                buffer.is_focused
                and get_hex('Normal', 'fg')
                or get_hex('ColorColumn', 'bg')
        end,
    },
    -- sidebar = {
    --     filetype = 'neo-tree',
    --     components = {
    --         {
    --             text = '  Project',
    --             fg = yellow,
    --             bg = get_hex('NeoTreeTabInactive', 'bg'),
    --             style = 'bold',
    --         },
    --     }
    -- },
    components = {
        {
            text = function(buffer) return ' ' .. buffer.devicon.icon end,
            fg = function(buffer) return buffer.devicon.color end,
        },
        {
            text = function(buffer) return buffer.unique_prefix end,
            fg = get_hex('Comment', 'fg'),
            style = 'italic',
        },
        {
            text = function(buffer) return buffer.filename .. ' ' end,
        },
        {
            text = '',
            delete_buffer_on_left_click = true,
        },
        {
            text = ' ',
        }
    },
})

-- File explorer settings
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require('neo-tree').setup({
    window = {
        position = 'right'
    },
    sources = {
        'filesystem',
        -- 'buffers',
        'git_status',
        'document_symbols'
    },
    source_selector = {
        winbar = true,
        statusline = false,
        sources = {
            {source = 'filesystem'},
            {source = 'git_status'},
            {source = 'document_symbols'},
        },
    }
})

-- Statusbar settings
require('lualine').setup({
    options = {
        theme = 'onedark'
    }
})

-- Terminal
require 'term-edit'.setup {
    -- Mandatory option:
    -- Set this to a lua pattern that would match the end of your prompt.
    -- Or a table of multiple lua patterns where at least one would match the
    -- end of your prompt at any given time.
    -- For most bash/zsh user this is '%$ '.
    -- For most powershell/fish user this is '> '.
    -- For most windows cmd user this is '>'.
    prompt_end = '%$ ',
    -- How to write lua patterns: https://www.lua.org/pil/20.2.html
}

-- Colors
require('onedark').setup {
    style = 'darker'
}
require('onedark').load()

-- Startup actions
local function open_side_panes(data)
    -- Buffer is a directory
    local directory = vim.fn.isdirectory(data.file) == 1
    -- Or none supplied
    local no_name = data.file == '' and vim.bo[data.buf].buftype == ''
    if not directory and not no_name then
        return
    end
    -- change to the directory
    if directory then
        vim.cmd.cd(data.file)
    end
    -- open the tree
    vim.cmd 'Neotree'
end
vim.api.nvim_create_autocmd({'VimEnter'}, {callback = open_side_panes})
