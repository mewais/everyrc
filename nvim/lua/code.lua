-- Language Server Protocol
local lspconfig = require 'lspconfig'
lspconfig.bashls.setup {}
lspconfig.ccls.setup {
    init_options = {
        compilationDatabaseDirectory = './Build'
    }
}
lspconfig.cmake.setup {}
lspconfig.hdl_checker.setup {}
lspconfig.java_language_server.setup {}
lspconfig.pyright.setup {}
lspconfig.jsonls.setup {}
lspconfig.yamlls.setup {}

-- Code completion
vim.g.coq_settings = {auto_start = true}
local coq = require 'coq'
lspconfig.bashls.setup {}
lspconfig.ccls.setup {}
lspconfig.cmake.setup {}
lspconfig.hdl_checker.setup {}
lspconfig.java_language_server.setup {}
lspconfig.pyright.setup {}
lspconfig.jsonls.setup {}
lspconfig.yamlls.setup {}
require('copilot').setup({
    panel = {
        enabled = false,
        auto_refresh = false
    },
    suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
            accept = '<C-Right>'
        }
    },
    filetypes = {
        yaml = true,
        json = true,
        markdown = true,
        gitcommit = true,
        gitrebase = true
    }
})

-- CMake
require('cmake-tools').setup {
    cmake_command = 'cmake',
    cmake_build_directory = 'Build/',
    cmake_build_directory_prefix = 'Build/', -- when cmake_build_directory is '', this option will be activated
--     cmake_generate_options = {'-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1'},
    cmake_build_options = {'-j4'},
    cmake_console_position = 'belowright', -- 'belowright', 'aboveleft', ...
}

-- Git
require('vgit').setup()

-- Markdown
require('glow').setup({
    style = 'dark',
    width = 200,
    height = 150,
})
