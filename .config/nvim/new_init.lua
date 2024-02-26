--[[
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.wrap = false

vim.o.relativenumber = true

vim.o.scrolloff = 8


vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true


-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = ""

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

--  Basic Keymaps 

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- move highlighted text in V mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- past without removing from buffer
vim.keymap.set("x", "P", "\"_dP")

-- yank into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- C-j and k remaps for c-u and c-d. we also center the view with zz
vim.keymap.set("n", "<C-h>", "<C-d>zz")
vim.keymap.set("n", "<C-l>", "<C-u>zz")

-- remap number increment to avoid harpoon
vim.keymap.set("n", "<C-z>", "<C-a>")

-- open netRW
vim.keymap.set("n", "<leader>fv", vim.cmd.Ex, { desc = "netRW, file" })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })



local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "j-hui/fidget.nvim",
        opts = {
            -- options
        },
        {
            "rose-pine/neovim",
            name = "rose-pine",
            config = function()
                require("rose-pine").setup({})
                vim.cmd.colorscheme 'rose-pine'
            end
        },
        {
            "nvim-telescope/telescope.nvim",
            tag = "0.1.5",
            dependencies = {
                "nvim-lua/plenary.nvim"
            },
            config = function()
                local builtin = require("telescope.builtin")
                vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles"})
                vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "[L]ive [G]rep"})
                vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers"})
                vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = "[S]earch [C]ommands"})
                vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp"})
                vim.keymap.set("n", "<leader>sr", builtin.registers, { desc = "[S]earch [R]registers"})
                vim.keymap.set("n", "<leader>ss", builtin.spell_suggest, { desc = "[S]pell [S]uggest"})
                vim.keymap.set("n", "<leader>cf", builtin.current_buffer_fuzzy_find, { desc = "[C]urrent buffer [F]uzzy find"})

                vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics"})
                vim.keymap.set("n", "<leader>gr", builtin.lsp_references, { desc = "[G]o to [R]eferences"})
            end
        },
        {
            "williamboman/mason-lspconfig.nvim",
            dependencies = {
                "williamboman/mason.nvim",
                "neovim/nvim-lspconfig",
            },
            config = function()
                require("mason").setup()
                require("mason-lspconfig").setup{
                    ensure_installed = { "lua_ls", "rust_analyzer", "html", "cssls"},
                    handlers = {
                        function(server_name)
                            require("lspconfig")[server_name].setup({})
                        end
                    }
                }
            end
        },
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",

                "onsails/lspkind.nvim",

                'L3MON4D3/LuaSnip',
                'saadparwaiz1/cmp_luasnip',
            },
            config = function()
                local cmp = require("cmp");
                local luasnip = require("luasnip")
                local lspkind = require('lspkind')
                require('luasnip.loaders.from_vscode').lazy_load()
                luasnip.config.setup {}
                cmp.setup {
                    snippet = {
                        expand = function(args)
                            luasnip.lsp_expand(args.body)
                        end,
                    },
                    mapping = cmp.mapping.preset.insert {
                        ['<C-n>'] = cmp.mapping.select_next_item(),
                        ['<C-p>'] = cmp.mapping.select_prev_item(),
                        ['<C-d>'] = cmp.mapping.scroll_docs( -4),
                        ['<C-f>'] = cmp.mapping.scroll_docs(4),
                        ['<C-Space>'] = cmp.mapping.complete {},
                        ['<CR>'] = cmp.mapping.confirm {
                            behavior = cmp.ConfirmBehavior.Replace,
                            select = true,
                        },
                        ['<Tab>'] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item()
                            elseif luasnip.expand_or_locally_jumpable() then
                                luasnip.expand_or_jump()
                            else
                                fallback()
                            end
                        end, { 'i', 's' }),
                        ['<S-Tab>'] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item()
                            elseif luasnip.locally_jumpable( -1) then
                                luasnip.jump( -1)
                            else
                                fallback()
                            end
                        end, { 'i', 's' }),
                    },

                    sources = {
                        { name = 'nvim_lsp' },
                        { name = 'luasnip' },
                        { name = 'async_path' },
                    },

                    formatting = {
                        format = lspkind.cmp_format({
                            maxwidth = 30,
                            ellipsis_char = '󰇘',
                            mode = "symbol_text",
                            menu = ({
                                buffer = "[Buf]",
                                nvim_lsp = "[LSP]",
                                luasnip = "[Snip]",
                                async_path = "[Path]",
                            })
                        }),
                    },
                }
            end,
        },
    }
})
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- idk what this is even doing
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = ev.buf }

        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]o to [D]efinition", unpack(opts) })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "lsp hover", unpack(opts)  })
        vim.keymap.set("i", "C-h", vim.lsp.buf.signature_help, { desc = "signature help", unpack(opts)  })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[N]ame", unpack(opts)  })
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction", unpack(opts)  })
        vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
        end, { desc = "[C]ode [A]ction", unpack(opts)  })
    end
})

--]]
