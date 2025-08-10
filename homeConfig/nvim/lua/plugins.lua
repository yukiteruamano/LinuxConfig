---------------------------------
-- Init and setup plugin manager
---------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {"max397574/better-escape.nvim", event = "InsertCharPre", opts = { timeout = 300 } },
    {"nvim-tree/nvim-web-devicons", commit = "eb8f80f30fd5e9a6176dee5c46661ebd7437ac46"},
    {"akinsho/bufferline.nvim", commit = "d24378edc14a675c820a303b4512af3bbc5761e9"},
    {"nmac427/guess-indent.nvim", commit = "b8ae749fce17aa4c267eec80a6984130b94f80b2"},
    {"tversteeg/registers.nvim", commit = "2ab8372bb837f05fae6b43091f10a0b725d113ca"},
    {"neovim/nvim-lspconfig", commit = "c0de180ddb3df36feef8ac3607670894d0e7497f"},
    {"folke/neodev.nvim", commit = "9f0205a08757711f57589a1dffa8abf525f4a23b"},
    { "nvim-treesitter/nvim-treesitter", 
        commit = "8d5e5dc40a4c480483690777cefb8cf67e710702", 
        build = ":TSUpdate" 
    },
    {"hrsh7th/cmp-nvim-lsp", commit = "44b16d11215dce86f253ce0c30949813c0a90765"},
    {"hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa"},
    {"hrsh7th/cmp-path", commit = "91ff86cd9c29299a64f968ebb45846c485725f23"},
    {"hrsh7th/cmp-cmdline", commit = "8ee981b4a91f536f52add291594e89fb6645e451"},
    {"hrsh7th/nvim-cmp", commit = "c4e491a87eeacf0408902c32f031d802c7eafce8"},
    {"rafamadriz/friendly-snippets", commit = "bc38057e513458cb2486b6cd82d365fa294ee398"},
    {"nvim-telescope/telescope-fzf-native.nvim",
        commit = "9bc8237565ded606e6c366a71c64c0af25cd7a50", 
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && \
            cmake --build build --config Release && \
            cmake --install build --prefix build" 
    },
    {"nvim-telescope/telescope.nvim", 
        commit = "776b509f80dd49d8205b9b0d94485568236d1192",
        branch = "0.1.x"
    },
    {"jose-elias-alvarez/null-ls.nvim", commit = "db09b6c691def0038c456551e4e2772186449f35"},
    { "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "2.*", 
        -- install jsregexp (optional!).
        build = "make install_jsregexp" 
    },
    {"saadparwaiz1/cmp_luasnip", commit = "18095520391186d634a0045dacaa346291096566"},
    {"nvim-lua/plenary.nvim", commit = "267282a9ce242bbb0c5dc31445b6d353bed978bb"},
    {"kdheepak/lazygit.nvim", commit = "1578fa3db0a707393d690a2357e7de6a47081ce0"},
    {"windwp/nvim-autopairs", commit = "ae5b41ce880a6d850055e262d6dfebd362bb276e"},
    {"numToStr/FTerm.nvim", commit = "d1320892cc2ebab472935242d9d992a2c9570180"},
    {"ibhagwan/fzf-lua", commit = "77c24ecce152bc32c0e99620cab5d03309ed3438"},
    {"lukas-reineke/indent-blankline.nvim", 
        commit = "4541d690816cb99a7fc248f1486aa87f3abce91c"
    },
    {"folke/trouble.nvim", commit = "40aad004f53ae1d1ba91bcc5c29d59f07c5f01d3"},
    {"nvim-lualine/lualine.nvim", commit = "45e27ca739c7be6c49e5496d14fcf45a303c3a63"},
    { "catppuccin/nvim", 
        name = "catppuccin", 
        priority = 1000 
    },
    {"nvim-neo-tree/neo-tree.nvim", branch = "v3.x" },  
    {"folke/which-key.nvim", commit = "bf09a25bdc9a83bcc69d2cf078e680368676513b"},
    {"folke/noice.nvim", event = "VeryLazy", 
        opts = {
        -- add any options here
        },
        dependencies = {
            {"MunifTanjim/nui.nvim", version = "^0.2"}, 
            {"rcarriga/nvim-notify", version = "^3"},
        },
    },
})

-----------------------
-- Simple setup plugins
-----------------------
require("nvim-web-devicons").setup()
require("nvim-autopairs").setup()
require("luasnip.loaders.from_vscode").lazy_load()
require("trouble").setup()
require("better_escape").setup()
require("guess-indent").setup({})
require("lazy").setup()


-------------------------
-- Advanced setup plugins
-------------------------

-- Bufferline
require("bufferline").setup()

-- WhichKey
local wk = require("which-key")
wk.register(mappings, opts)

-- Noice
require("noice").setup({
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    -- you can enable a preset for easier configuration
    presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
    },
})

-- Neodev
require("neodev").setup({
    library = {
        enabled = true,
        runtime = true, -- runtime path
        types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
        plugins = true, -- installed opt or start plugins in packpath
    },
    setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
    override = function(root_dir, options) end,
    lspconfig = false,
    pathStrict = true,
})

-- Lualine
require("lualine").setup {
    options = {
        icons_enabled = true,
        theme = "catppuccin-mocha",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },

    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff",
            { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = "󰛩 " }, }, },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

-- FTerm
require "FTerm".setup({
    ft = "FTerm",
    border     = "single",
    cmd = os.getenv("SHELL"),
    dimensions = {
        height = 0.80,
        width = 0.80,
        x = 0.5,
        y = 0.5,
    },
})

-- Fterm options
vim.api.nvim_create_user_command("FTermOpen", require("FTerm").open, { bang = true })
vim.api.nvim_create_user_command("FTermClose", require("FTerm").close, { bang = true })
vim.api.nvim_create_user_command("FTermExit", require("FTerm").exit, { bang = true })
vim.api.nvim_create_user_command("FTermToggle", require("FTerm").toggle, { bang = true })

-- Fterm for lazygit
local fterm = require("FTerm")
local lazygit = fterm:new({
    ft = "fterm_lazygit", -- You can also override the default filetype, if you want
    cmd = "lazygit",
    dimensions = {
        height = 0.80,
        width = 0.80,
        x = 0.5,
        y = 0.5,
    },
})

-- Use this to toggle Lazygit in a floating terminal
vim.keymap.set("n", "<Leader>Lg", function() lazygit:toggle() end)

-- Treesitter
require "nvim-treesitter.configs".setup {
    ensure_installed = { 
        "bash", 
        "c", 
        "cpp", 
        "cmake",
        "comment",
        "css",
        "diff",
        "dockerfile",
        "dot",
        "glsl",
        "go",
        "html",
        "javascript",
        "json",
        "lua", 
        "markdown",
        "meson",
        "perl",
        "python",
        "rust",
        "typescript",
        "vim", 
        "vimdoc", 
        "yaml"
    },
    highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = true,
    },
    incremental_selection = {
        enable = true,
    },
    indent = { enable = false},
}

-- FzfLua
require "fzf-lua".setup {
    winopts = {
        height = 0.40, -- window height
        width  = 1,    -- window width
        row    = 1,    -- window row position (0=top, 1=bottom)
        col    = 0,    -- window col position (0=left, 1=right)
        border = false,
    }
}

-- Registers
require("registers").setup({
    window = {
        max_width = 100,
        highlight_cursorline = true,
        border = "single",
        transparency = 0,
    },
})

-- Telescope fzf native
-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require("telescope").setup {
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                             -- the default case_mode is "smart_case"
        }
    }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("fzf")

-- Cmp
require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require("cmp")
local luasnip = require("luasnip")
local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    sources = {
        { name = "path" },
        { name = "nvim_lsp", keyword_length = 1 },
        { name = "buffer",   keyword_length = 3 },
        { name = "luasnip",  keyword_length = 2 },
    },
    window = {
        documentation = cmp.config.window.bordered({
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
            border = { "", "", "", " ", "", "", "", " " },
    }),
    },
    formatting = {
    fields = { "menu", "abbr", "kind" },
    format = function(entry, item)
        item.abbr = string.sub(item.abbr, 1, 20)
            local menu_icon = {
                    nvim_lsp = "λ",
                    luasnip = "⋗",
                    buffer = "Ω",
                    path = "🖫",
                }
            item.menu = menu_icon[entry.source.name]
        return item
        end,
    },
    mapping = {
        ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
        ["<Down>"] = cmp.mapping.select_next_item(select_opts),

        ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
        ["<C-n>"] = cmp.mapping.select_next_item(select_opts),

        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),

        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),

        ["<C-f>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(1) then
            luasnip.jump(1)
        else
            fallback()
        end
        end, { "i", "s" }),

        ["<C-b>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<Tab>"] = cmp.mapping(function(fallback)
          local col = vim.fn.col(".") - 1

          if cmp.visible() then
            cmp.select_next_item(select_opts)
          elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
            fallback()
          else
            cmp.complete()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item(select_opts)
          else
            fallback()
          end
    end, { "i", "s" }),
    },
})
