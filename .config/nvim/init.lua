local set_vim_opt = function(opts)
    for n, v in pairs(opts) do
        vim.opt[n] = v
    end
end

set_vim_opt {
    relativenumber = true,
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    ignorecase = true,
    smartcase = true,
}

local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add {
    -- dependencies
    gh 'nvim-tree/nvim-web-devicons',
    gh 'nvim-lua/plenary.nvim',
    gh 'MunifTanjim/nui.nvim',

    -- main
    gh 'nvim-telescope/telescope.nvim', -- searcher
    gh 'folke/which-key.nvim',
    gh 'nvim-neo-tree/neo-tree.nvim',
    gh 'stevearc/conform.nvim', -- formatter
    gh 'neovim/nvim-lspconfig',

    -- themes
    gh 'catppuccin/nvim',
}

local cfm = require 'conform'
cfm.setup {
    formatters_by_ft = {
        c = { 'clang-format' },
        go = { 'gofmt' },
        cpp = { 'clang-format' },
        lua = { 'customized_stylua' },
        rust = { 'rustfmt' },
        python = { 'black' },
        javascript = { 'deno_fmt' },
    },
    formatters = {
        customized_stylua = {
            inherit = 'stylua',
            prepend_args = {
                '--call-parentheses',
                'Input',
                '--collapse-simple-statement',
                'Always',
                '--indent-type',
                'Spaces',
                '--quote-style',
                'AutoPreferSingle',
            },
        },
    },
}

vim.api.nvim_create_user_command('Format', function() cfm.format { async = true, lsp_format = 'fallback' } end, {})

require 'neo-tree'.setup {}

require 'nvim-web-devicons'.setup()

local wk = require 'which-key'
wk.setup {
    preset = 'helix',
    win = {
        border = 'single',
        title = false,
        wo = {
            winblend = 100,
        },
    },
    icons = {
        mappings = false,
    },
    show_help = false,
    show_keys = false,
}

local telblt = require 'telescope.builtin'

wk.add {
    { '<leader>f', group = 'file' },
    { '<leader>ff', telblt.find_files, desc = 'find files' },
    { '<leader>fg', telblt.live_grep, desc = 'search by ripgrep' },
    { '<leader>fb', telblt.buffers, desc = 'search in buffers' },
    { '<leader>fh', telblt.help_tags, desc = 'telescope help' },

    { '<leader>l', group = 'list' },
    { '<leader>lj', telblt.jumplist, desc = 'telescope jumplist' },
    { '<leader>lb', telblt.builtin, desc = 'list builtin picker' },

    {
        '<leader>m',
        function() cfm.format { async = true } end,
        desc = 'format',
    },

    { 'gd', vim.lsp.buf.definition, desc = 'vim.lsp.buf.definition' },
    { 'gD', vim.lsp.buf.declaration, desc = 'vim.lsp.buf.declaration' },
}

require 'catppuccin'.setup {
    flavour = 'mocha',
    transparent_background = true,

    float = { transparent = true },
}
vim.cmd.colorscheme 'catppuccin-mocha'

-- vim.lsp.enable { 'clangd', 'rust', 'pylsp', 'go' }

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method 'textDocumnet/completion' then
            vim.lsp.completion.enable(true, client.id, ev.buf, {})
        end
    end,
})

vim.diagnostic.config { virtual_lines = true }

vim.lsp.config('pylsp', {
    settings = {
        pylsp = {

            disableDiagnostics = true,
            plugins = {

                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
                pylint = { enabled = false },
                pylsp_mypy = {
                    enabled = true,
                    live_mode = true,
                    strict = false,
                    hover = true,
                },
                flake8 = { enabled = false },
                mccabe = { enabled = false },
                pydocstyle = { enabled = false },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
                pylsp_black = { enabled = false },
                pylsp_isort = { enabled = false },

                jedi_completion = { enabled = true },
                jedi_definition = { enabled = true },
                jedi_hover = { enabled = true },
                jedi_references = { enabled = true },
                jedi_signature_help = { enabled = true },
                jedi_symbols = { enabled = true },
                rope_completion = { enabled = true },
            },
        },
    },

    handlers = {
        ['textDocument/publishDiagnostics'] = function() end,
    },
})
