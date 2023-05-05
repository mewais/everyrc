-- Install the Packer plugin manager first
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') ..  '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function()
    -- Let the package manager update itself
    use 'wbthomason/packer.nvim'

    -- Prerequisites
    use 'nvim-lua/plenary.nvim'
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-telescope/telescope.nvim'
    use 'MunifTanjim/nui.nvim'

    -- LSP
    use 'neovim/nvim-lspconfig'

    -- File explorer
    use {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x',
    }

    -- Statusbar
    use 'nvim-lualine/lualine.nvim'

    -- Winbar
    use 'willothy/nvim-cokeline'

    -- Terminal
    use {'chomosuke/term-edit.nvim', tag = 'v1.*'}

    -- Code completion
    use 'ms-jpq/coq_nvim'
    use 'zbirenbaum/copilot.lua'

    -- Git
    use 'tanvirtin/vgit.nvim'
    use 'kdheepak/lazygit.nvim'

    -- Markdown
    use 'ellisonleao/glow.nvim'

    -- YAML
    use {
        'someone-stole-my-name/yaml-companion.nvim',
        config = function()
            require('telescope').load_extension('yaml_schema')
        end,
    }

    -- CMake
    use 'Civitasv/cmake-tools.nvim'

    -- GDB
    use 'sakhnik/nvim-gdb'

    -- Color
    use 'navarasu/onedark.nvim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
