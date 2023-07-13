--------------------------------------------------------------------------------
-- General neovim configuration
--------------------------------------------------------------------------------
-- Map leader to space
vim.g.mapleader = ","

-- Always enable colors in neovim
vim.opt.termguicolors = true

-- Enable more mouse controls
vim.opt.mouse = "a"

-- Backspace to remove indents
vim.opt.backspace = {"indent", "eol", "start"}
vim.opt.smartcase = true

-- Scroll before reaching end
vim.opt.scrolloff = 4

-- Default tab handling
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Searching
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"

-- Undo settings
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

-- Allow buffers not being saved
vim.opt.hidden = true

-- Time for cursor hold
vim.o.updatetime = 100

-- Removes blinking of the sign column
vim.opt.signcolumn = "yes:1"

-- Always show status line
vim.opt.laststatus = 2

-- Show line numbers
vim.opt.number = true

-- Text wrap
vim.opt.textwidth = 100

-- Try without these
vim.opt.cindent = true
vim.opt.conceallevel = 0

vim.cmd [[set fillchars+=vert:│]]
vim.cmd [[set undodir=~/.config/nvim/undodir]]
vim.cmd [[set backupdir=~/.config/nvim/swaps]]
vim.cmd [[set directory=~/.config/nvim/swaps]]
vim.cmd [[set statusline=%<%F\ %h%m%r%=%-14.(%l,%c%V%)\ %P]]
vim.cmd [[set cmdheight=2]]
vim.cmd [[set completeopt=menu,menuone,noselect]]
vim.cmd [[set pumheight=25]]
vim.cmd [[set shortmess+=c]]

-- call camelcasemotion#CreateMotionMappings('<leader>')

--------------------------------------------------------------------------------
-- Lazy package
--------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- LuaFormatter off
require("lazy").setup({
    -- Color schemes
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "marko-cerovac/material.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("material").setup({
                contrast = {
                    sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
                    floating_windows = true, -- Enable contrast for floating windows
                    line_numbers = false, -- Enable contrast background for line numbers
                    sign_column = false, -- Enable contrast background for the sign column
                    cursor_line = false, -- Enable darker background for the cursor line
                    non_current_windows = false, -- Enable darker background for non-current windows
                    popup_menu = false, -- Enable lighter background for the popup menu
                },

                styles = { -- Give comments style such as bold, italic, underline etc.
                    comments = { italic = true },
                    strings = {  italic = true },
                    keywords = {  underline = true },
                    functions = {  bold = true },
                    variables = { italic = true},
                    operators = {  bold = true },
                    types = {},
                },

                high_visibility = {
                    lighter = false, -- Enable higher contrast text for lighter style
                    darker = true -- Enable higher contrast text for darker style
                },

                disable = {
                    colored_cursor = false, -- Disable the colored cursor
                    borders = false, -- Disable borders between verticaly split windows
                    background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
                    term_colors = false, -- Prevent the theme from setting terminal colors
                    eob_lines = false -- Hide the end-of-buffer lines
                },

                lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

                async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

                -- custom_highlights = {}, -- Overwrite highlights with your own
                custom_highlights = {
                    DiffAdd = { reverse = false },
                    DiffChange = { reverse = false },
                    DiffDelete = { reverse = false },
                    ["@comment"] = { fg = '#777777' },
                    ["@spell"] = { fg = '#777777' },
                    ["TSComment"] = { fg = '#777777' },
                    ["@function.macro"] = { fg = '#999999' },
                },
                custom_colors = function(colors)
                    colors.editor.selection = "#444444"
                end,

                plugins = { -- Here, you can disable(set to false) plugins that you don't use or don't want to apply the theme to
                    trouble = true,
                    nvim_cmp = true,
                    neogit = true,
                    gitsigns = false,
                    git_gutter = false,
                    telescope = true,
                    nvim_tree = false,
                    sidebar_nvim = false,
                    lsp_saga = false,
                    nvim_dap = true,
                    nvim_navic = true,
                    which_key = true,
                    sneak = true,
                    hop = true,
                    indent_blankline = true,
                    nvim_illuminate = true,
                    mini = true,
                }
            })
            vim.cmd [[colorscheme material]]
        end
    },

    -- Show colors
    {
        "norcalli/nvim-colorizer.lua",
        lazy = false,
    },

    -- Status line
    {
        "hoob3rt/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            options = {
                icons_enabled = true,
                theme = "tokyonight",
                component_separators = {"", ""},
                section_separators = {"", ""},
                disabled_filetypes = {}
            },
            sections = {
                lualine_a = {"mode"},
                -- lualine_b = {"branch"},
                lualine_b = {'branch', 'diff'},
                lualine_c = {"filename"},
                lualine_x = {"encoding", "fileformat", "filetype", {'diagnostics', sources={'nvim_diagnostic', 'coc'}}},
                lualine_y = {"progress"},
                lualine_z = {"location"}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {"filename"},
                lualine_x = {"location"},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            extensions = {}
        }
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        keys = {
            {"<leader>f", ":lua require('telescope.builtin').find_files()<cr>"},
            {"<leader>j", ":lua require('telescope.builtin').git_files()<cr>"},
            {"<leader>g", ":lua require('telescope.builtin').live_grep()<cr>"},
            {"<leader>b", ":lua require('telescope.builtin').buffers()<cr>"},
            {"<leader>h", ":lua require('telescope.builtin').help_tags()<cr>"},
            {"<leader>s", ":lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>"},
        },
        config = function()
            local telescope = require("telescope")
            local tactions = require('telescope.actions')

            telescope.setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-c>"] = false,
                            ["<C-l>"] = tactions.close,
                        }
                    },
                    theme = "dropdown",
                    winblend = 20,
                    sorting_strategy = "ascending",
                    layout_strategy = "center",
                    results_title = false,
                    preview_title = "Preview",
                    -- preview_cutoff = 1, -- Preview should always show (unless previewer = false)
                    layout_config = {
                        width = 0.7,
                        height = 0.7,
                        preview_cutoff = 1, -- Preview should always show (unless previewer = false)
                    },
                    -- width = 0.7,
                    -- results_height = 0.7,
                    borderchars = {
                        {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
                        prompt = {"─", "│", " ", "│", "╭", "╮", "│", "│"},
                        results = {"─", "│", "─", "│", "├", "┤", "╯", "╰"},
                        preview = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"}
                    }
                }
            })
        end,
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/playground",
        },
        config = function()
            require"nvim-treesitter.configs".setup {
                -- ensure_installed = "maintained",
                highlight = {
                    enable = true,
                    disable = {"json"} -- list of language that will be disabled
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn",
                        node_incremental = "grn",
                        scope_incremental = "grc",
                        node_decremental = "grm",
                    },
                },
                textobjects = {
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>a"] = "@parameter.inner",
                            ["<leader>o"] = "@function.outer",
                        },
                        swap_previous = {
                            ["<leader>A"] = "@parameter.inner",
                            ["<leader>O"] = "@function.outer",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["<leader>t"] = "@function.outer",
                            ["]]"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["<leader>T"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["<leader>b"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["<leader>B"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                    },
                },
                context_commentstring = {
                    enable = true
                },
                playground = {
                    enable = true,
                    disable = {},
                    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                    persist_queries = false, -- Whether the query persists across vim sessions
                    keybindings = {
                        toggle_query_editor = 'o',
                        toggle_hl_groups = 'i',
                        toggle_injected_languages = 't',
                        toggle_anonymous_nodes = 'a',
                        toggle_language_display = 'I',
                        focus_language = 'f',
                        unfocus_language = 'F',
                        update = 'R',
                        goto_node = '<cr>',
                        show_help = '?',
                    },
                }
            }
        end,
    },

    -- Git - tpope!
    "tpope/vim-fugitive",

    -- Git signs
    {
        "lewis6991/gitsigns.nvim",
        dependencies = {"nvim-lua/plenary.nvim"},
        lazy = false,
        config = function()
            require("gitsigns").setup({
                signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
                numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir = {
                    interval = 2000,
                    follow_files = true
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, {expr=true})

                    map('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, {expr=true})

                    -- Actions
                    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
                    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
                    map('n', '<leader>hS', gs.stage_buffer)
                    map('n', '<leader>hu', gs.undo_stage_hunk)
                    -- map('n', '<leader>hR', gs.reset_buffer)
                    map('n', '<leader>hp', gs.preview_hunk)
                    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
                    -- map('n', '<leader>tb', gs.toggle_current_line_blame)
                    map('n', '<leader>hd', gs.diffthis)
                    map('n', '<leader>hD', function() gs.diffthis('~') end)
                    -- map('n', '<leader>td', gs.toggle_deleted)

                    -- Text object
                    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                end
            })
        end,
    },

    -- Plugins unknown to Anton
    {
        "nat-418/boole.nvim",
        opts = {
            mappings = {
                increment = '<C-a>',
                decrement = '<C-x>'
            }
        },
    },
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup({
                -- Animation style (see below for details)
                stages = "fade_in_slide_out",

                -- Function called when a new window is opened, use for changing win settings/config
                on_open = nil,

                -- Function called when a window is closed
                on_close = nil,

                -- Render function for notifications. See notify-render()
                render = "default",

                -- Default timeout for notifications
                timeout = 8000,

                -- Max number of columns for messages
                max_width = nil,
                -- Max number of lines for a message
                max_height = nil,

                -- For stages that change opacity this is treated as the highlight behind the window
                -- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
                background_colour = "#000000",

                -- Minimum width for notification windows
                minimum_width = 50,

                -- Icons for the different levels
                icons = {
                    ERROR = "",
                    WARN = "",
                    INFO = "",
                    DEBUG = "",
                    TRACE = "✎",
                },
            })
        end
    },
    {
        "simrat39/symbols-outline.nvim",
        config = function()
            require('symbols-outline').setup{
                -- whether to highlight the currently hovered symbol
                -- disable if your cpu usage is higher than you want it
                -- or you just hate the highlight
                -- default: true
                highlight_hovered_item = true,

                -- whether to show outline guides
                -- default: true
                show_guides = true,
            }
            local function replace_keycodes(str)
                return vim.api.nvim_replace_termcodes(str, true, true, true)
            end

            function _G.tab_binding()
                if vim.fn.pumvisible() ~= 0 then
                    return replace_keycodes("<C-n>")
                elseif vim.fn["vsnip#available"](1) ~= 0 then
                    return replace_keycodes("<Plug>(vsnip-expand-or-jump)")
                else
                    return replace_keycodes("<Plug>(Tabout)")
                end
            end

            function _G.s_tab_binding()
                if vim.fn.pumvisible() ~= 0 then
                    return replace_keycodes("<C-p>")
                elseif vim.fn["vsnip#jumpable"](-1) ~= 0 then
                    return replace_keycodes("<Plug>(vsnip-jump-prev)")
                else
                    return replace_keycodes("<Plug>(TaboutBack)")
                end
            end

            vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_binding()", {expr = true})
            vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_binding()", {expr = true})
        end,
    },
    {
        "abecodes/tabout.nvim",
        config = function()
            require("tabout").setup({
                tabkey = "",
                backwards_tabkey = "",
                completion = true, -- if the tabkey is used in a completion pum
                tabouts = {
                    {open = "'", close = "'"},
                    {open = '"', close = '"'},
                    {open = '`', close = '`'},
                    {open = '(', close = ')'},
                    {open = '[', close = ']'},
                    {open = '{', close = '}'}
                },
            })
        end
    },
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {
                plugins = {
                    marks = true, -- shows a list of your marks on ' and `
                    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
                    -- No actual key bindings are created
                    spelling = {
                        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                        suggestions = 20, -- how many suggestions should be shown in the list?
                    },
                    presets = {
                        operators = true, -- adds help for operators like d, y, ...
                        motions = true, -- adds help for motions
                        text_objects = true, -- help for text objects triggered after entering an operator
                        windows = true, -- default bindings on <c-w>
                        nav = true, -- misc bindings to work with windows
                        z = true, -- bindings for folds, spelling and others prefixed with z
                        g = true, -- bindings for prefixed with g
                    },
                },
                -- add operators that will trigger motion and text object completion
                -- to enable all native operators, set the preset / operators plugin above
                operators = { gc = "Comments" },
                key_labels = {
                    -- override the label used to display some keys. It doesn't effect WK in any other way.
                    -- For example:
                    -- ["<space>"] = "SPC",
                    -- ["<cr>"] = "RET",
                    -- ["<tab>"] = "TAB",
                },
                motions = {
                    count = true,
                },
                icons = {
                    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
                    separator = "➜", -- symbol used between a key and it's label
                    group = "+", -- symbol prepended to a group
                },
                popup_mappings = {
                    scroll_down = "<c-d>", -- binding to scroll down inside the popup
                    scroll_up = "<c-u>", -- binding to scroll up inside the popup
                },
                window = {
                    border = "single", -- none, single, double, shadow
                    position = "bottom", -- bottom, top
                    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
                    padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
                    winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
                },
                layout = {
                    height = { min = 4, max = 25 }, -- min and max height of the columns
                    width = { min = 20, max = 50 }, -- min and max width of the columns
                    spacing = 3, -- spacing between columns
                    align = "left", -- align columns left, center or right
                },
                ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
                hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " }, -- hide mapping boilerplate
                show_help = true, -- show a help message in the command line for using WhichKey
                show_keys = true, -- show the currently pressed key and its label as a message in the command line
                triggers = "auto", -- automatically setup triggers
                -- triggers = {"<leader>"} -- or specifiy a list manually
                -- list of triggers, where WhichKey should not wait for timeoutlen and show immediately
                triggers_nowait = {
                    -- marks
                    "`",
                    "'",
                    "g`",
                    "g'",
                    -- registers
                    '"',
                    "<c-r>",
                    -- spelling
                    "z=",
                },
                triggers_blacklist = {
                    -- list of mode / prefixes that should never be hooked by WhichKey
                    -- this is mostly relevant for keymaps that start with a native binding
                    i = { "j", "k" },
                    v = { "j", "k" },
                },
                -- disable the WhichKey popup for certain buf types and file types.
                -- Disabled by deafult for Telescope
                disable = {
                    buftypes = {},
                    filetypes = {},
                },
            }
        end
    },

    -- Syntax
    "udalov/kotlin-vim",
    "leafgarland/typescript-vim",

    -- Format
    {
        "sbdchd/neoformat",
        keys = {
            {"<leader>cf", ":Neoformat<CR>", mode = "n"},
            {"<leader>cf", ":Neoformat<CR>", mode = "v"},
        },
        config = function()
            -- Prioritize eslint-formatter for javascript
            vim.g.neoformat_enabled_javascript = { "prettier" }
            vim.g.neoformat_enabled_python = {"autopep8"}
            vim.g.neoformat_python_autopep8 = {
                exe =  "autopep8",
                args = {"--ignore", "E402", "--max-line-length", "100"},
            }
        end,
    },

    -- The mighty LSP
    "folke/lsp-trouble.nvim",
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "ray-x/lsp_signature.nvim",
            "simrat39/rust-tools.nvim",
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        lazy = false,
        keys = {
            {"gD", ":lua vim.lsp.buf.declaration()<cr>"},
            {"gw", ":lua vim.lsp.buf.workspace_symbol()<cr>"},
            {"gr", ":lua vim.lsp.buf.references()<cr>"},
            {"gi", ":lua vim.lsp.buf.implementation()<cr>"},
            {"<c-k>", ":lua vim.lsp.buf.signature_help()<cr>"},
        },
        config = function()
            require("trouble").setup {}

            local nvim_lsp = require("lspconfig")
            local client_caps = vim.lsp.protocol.make_client_capabilities()
            local capabilities = require('cmp_nvim_lsp').default_capabilities(client_caps)

            local cfg = {
                bind = true, -- This is mandatory, otherwise border config won't get registered.
                -- If you want to hook lspsaga or other signature handler, pls set to false
                doc_lines = 2, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                -- set to 0 if you DO NOT want any API comments be shown
                -- This setting only take effect in insert mode, it does not affect signature help in normal
                -- mode, 10 by default

                floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
                fix_pos = true,  -- set to true, the floating window will not auto-close until finish all parameters
                hint_enable = true, -- virtual hint enable
                hint_prefix = "🐼 ",  -- Panda for parameter
                hint_scheme = "String",
                use_lspsaga = false,  -- set to true if you want to use lspsaga popup
                hi_parameter = "Search", -- how your parameter will be highlight
                max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
                -- to view the hiding contents
                max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
                handler_opts = {
                    border = "shadow"   -- double, single, shadow, none
                },
                --extra_trigger_chars = {",", "("}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
                -- extra_trigger_chars = {".", ","} -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
                -- deprecate !!
                -- decorator = {"`", "`"}  -- this is no longer needed as nvim give me a handler and it allow me to highlight active parameter in floating_window
            }
            local on_attach_lsp = function() require("lsp_signature").on_attach(cfg) end


            require("clangd_extensions").setup {
                server = {
                    capabilities = capabilities,
                    on_attach = on_attach_lsp,
                    -- options to pass to nvim-lspconfig
                    -- i.e. the arguments to require("lspconfig").clangd.setup({})
                },
                extensions = {
                    -- defaults:
                    -- Automatically set inlay hints (type hints)
                    autoSetHints = true,
                    -- These apply to the default ClangdSetInlayHints command
                    inlay_hints = {
                        -- Only show inlay hints for the current line
                        only_current_line = true,
                        -- Event which triggers a refersh of the inlay hints.
                        -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
                        -- not that this may cause  higher CPU usage.
                        -- This option is only respected when only_current_line and
                        -- autoSetHints both are true.
                        only_current_line_autocmd = "CursorHold",
                        -- whether to show parameter hints with the inlay hints or not
                        show_parameter_hints = true,
                        -- prefix for parameter hints
                        parameter_hints_prefix = "<- ",
                        -- prefix for all the other hints (type, chaining)
                        other_hints_prefix = "=> ",
                        -- whether to align to the length of the longest line in the file
                        max_len_align = false,
                        -- padding from the left if max_len_align is true
                        max_len_align_padding = 1,
                        -- whether to align to the extreme right or not
                        right_align = false,
                        -- padding from the right if right_align is true
                        right_align_padding = 7,
                        -- The color of the hints
                        highlight = "Comment",
                        -- The highlight group priority for extmark
                        priority = 100,
                    },
                    ast = {
                        role_icons = {
                            type = "",
                            declaration = "",
                            expression = "",
                            specifier = "",
                            statement = "",
                            ["template argument"] = "",
                        },

                        kind_icons = {
                            Compound = "",
                            Recovery = "",
                            TranslationUnit = "",
                            PackExpansion = "",
                            TemplateTypeParm = "",
                            TemplateTemplateParm = "",
                            TemplateParamObject = "",
                        },

                        highlights = {
                            detail = "Comment",
                        },
                        memory_usage = {
                            border = "none",
                        },
                        symbol_info = {
                            border = "none",
                        },
                    },
                }
            }

            nvim_lsp.clangd.setup {on_attach = on_attach_lsp}
            nvim_lsp.pylsp.setup {
                on_attach = on_attach_lsp,
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                maxLineLength = 100
                            }
                        }
                    }
                }
            }
            nvim_lsp.texlab.setup {on_attach = on_attach_lsp}
            nvim_lsp.jsonls.setup {on_attach = on_attach_lsp}
            nvim_lsp.html.setup {
                capabilities = capabilities,
                on_attach = on_attach_lsp,
                init_options = {
                    configurationSection = { "html", "css", "javascript" },
                    embeddedLanguages = {
                        css = true,
                        javascript = true,
                    },
                    provideFormatter = true,
                }
            }
            nvim_lsp.cmake.setup{on_attach = on_attach_lsp}
            nvim_lsp.bashls.setup {on_attach = on_attach_lsp}
            nvim_lsp.tsserver.setup {
                on_attach = on_attach_lsp,
                settings = {
                    cmd = {"typescript-language-server", "--stdio"},
                }
            }
            nvim_lsp.vimls.setup {on_attach = on_attach_lsp}
            nvim_lsp.gopls.setup {on_attach = on_attach_lsp}

            -- Rust tools will handle attaching the
            require("rust-tools").setup({
                server = {
                    on_attach = function(client)
                        on_attach_lsp()
                        client.server_capabilities.semanticTokensProvider = nil
                    end,
                }
            })

            require('lspconfig.ui.windows').default_options.border = 'single'

            vim.lsp.handlers["textDocument/hover"] =
                vim.lsp.with(vim.lsp.handlers.hover, {
                    -- Use a sharp border with `FloatBorder` highlights
                    border = "single"
                })

            vim.lsp.handlers["textDocument/publishDiagnostics"] =
                vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                    virtual_text = {
                        spacing = 2,
                        prefix = " ",
                    },
                    signs = true,
                    update_in_insert = false
                })

            vim.diagnostic.config({
                virtual_text = false,
                signs = true,
                underline = false,
                update_in_insert = true,
                severity_sort = false
            })

            local signs = {Error = "", Warn = "", Hint = "", Info = ""}
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
            end
        end,
    },

    -- Completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "onsails/lspkind.nvim",
        },
        config = function()
            local lspkind = require("lspkind")
            local types = require('cmp.types')
            local cmp = require("cmp")
            cmp.setup {
                mapping = {
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item({select = true}),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<Tab>"] = cmp.mapping.confirm({select = true}),
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.close(),
                    -- ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
                    -- ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),

                },
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    end,
                },
                -- You should specify your *installed* sources.
                sources = {
                    -- {name = "nvim_lsp"},
                    -- {name = "nvim_lsp", keyword_length = 3, group_index = 1, max_item_count = 30},
                    {name = "nvim_lsp", max_item_count = 15},
                    {name = "vsnip"},
                    {name = "path"},
                    {name = "buffer"},
                    {name = "nvim_lua"},
                },
                comparators = {
                    -- The built-in comparators:
                    cmp.config.compare.score,
                    cmp.config.compare.length,
                    cmp.config.compare.recently_used,
                    function(entry1, entry2)
                        local kind1 = entry1:get_kind()
                        kind1 = kind1 == types.lsp.CompletionItemKind.Text and 100 or kind1
                        local kind2 = entry2:get_kind()
                        kind2 = kind2 == types.lsp.CompletionItemKind.Text and 100 or kind2
                        if kind1 ~= kind2 then
                            if kind1 == types.lsp.CompletionItemKind.Variable then
                                return true
                            end
                            if kind2 == types.lsp.CompletionItemKind.Variable then
                                return false
                            end
                            local diff = kind1 - kind2
                            if diff < 0 then
                                return true
                            elseif diff > 0 then
                                return false
                            end
                        end
                    end,
                    cmp.config.compare.exact,
                    cmp.config.compare.offset,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.order,
                },
            }
            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })

            local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
            capabilities.textDocument.completion.completionItem.snippetSupport = true
        end,
    },
    -- Progress for lsp operations
    {
        "j-hui/fidget.nvim",
        lazy = false,
        config = function()
            require("fidget").setup{}
        end,
    },

    -- Debugger plugin
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require('dap')
            dap.adapters.lldb = {
                type = 'executable',
                command = '/usr/bin/lldb-vscode', -- adjust as needed
                name = "lldb"
            }

            dap.configurations.cpp = {
                {
                    name = "Launch",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                    args = {},

                    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
                    --
                    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
                    --
                    -- Otherwise you might get the following error:
                    --
                    --    Error on launch: Failed to attach to the target process
                    --
                    -- But you should be aware of the implications:
                    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
                    runInTerminal = false,
                },
            }
        end
    },

    -- Fzf
    {
        "junegunn/fzf",
        dir = "~/.fzf",
        build = "./install --all"
    },
    "junegunn/fzf.vim",



    "tpope/vim-surround",
    "tpope/vim-unimpaired",
    "tpope/vim-dispatch",

    "bkad/CamelCaseMotion",

    {
        "majutsushi/tagbar",
        keys = {
            {"<F2>", "<cmd>TagbarToogle<cr>", mode = "n"},
        },
        config = function()
            vim.g.tagbar_widht = 40
        end,
    },


    "voldikss/vim-floaterm",
    "voldikss/fzf-floaterm",

    "mhinz/vim-startify",

    {
        "michaelb/sniprun",
        build = "bash install.sh"
    },

    "phaazon/hop.nvim",

    "fedepujol/move.nvim",

    "tpope/vim-repeat",

    {
        "numToStr/FTerm.nvim",
        opts = {
            border = 'double',
            dimensions  = {
                height = 0.9,
                width = 0.9,
            },
        },
        keys = {
            {'<C-T>', '<CMD>lua require("FTerm").toggle()<CR>', "n"},
            {'<C-T>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', "t"},
        },
    },


    "p00f/clangd_extensions.nvim",

    "narutoxy/dim.lua",

    "smjonas/inc-rename.nvim",

    "tweekmonster/fzf-filemru",
    "jacoborus/tender.vim",

    {
        "gorbit99/codewindow.nvim",
        config = function()
            local codewindow = require('codewindow')
            codewindow.setup()
            codewindow.apply_default_keybinds()
        end,
    },

    {
        "https://gitlab.com/madyanov/svart.nvim",
        keys = {
            {"s", "<Cmd>Svart<CR>"},        -- begin exact search
            {"S", "<Cmd>SvartRegex<CR>"},   -- begin regex search
            {"gs", "<Cmd>SvartRepeat<CR>"}, -- repeat with last searched query
        },
        config = function()
            local svart = require("svart")

            svart.configure({
                key_cancel = "<Esc>",       -- cancel search
                key_delete_char = "<BS>",   -- delete query char
                key_delete_word = "<C-W>",  -- delete query word
                key_delete_query = "<C-U>", -- delete whole query
                key_best_match = "<CR>",    -- jump to the best match
                key_next_match = "<C-N>",   -- select next match
                key_prev_match = "<C-P>",   -- select prev match

                label_atoms = "jfkdlsahgnuvrbytmiceoxwpqz", -- allowed label chars
                label_location = -1,                        -- label location relative to the match
                -- positive = relative to the start of the match
                -- 0 or negative = relative to the end of the match
                label_max_len = 2,                          -- max label length
                label_min_query_len = 1,                    -- min query length required to show labels
                label_hide_irrelevant = true,               -- hide irrelevant labels after start typing label to go to
                label_conflict_foresight = 3,               -- number of chars from the start of the match to discard from labels pool

                search_update_register = false, -- update search (/) register with last used query after accepting match
                search_wrap_around = true,     -- wrap around when navigating to next/prev match
                search_multi_window = true,    -- search in multiple windows

                ui_dim_content = true, -- dim buffer content during search
            })
        end,
    },
    "eandrju/cellular-automaton.nvim",

    "tamton-aquib/zone.nvim",

    {
        "tamton-aquib/duck.nvim",
        keys = {
            {"<leader>dd", "<cmd> lua require('duck').hatch()<cr>"},
            {"<leader>dk", "<cmd> lua require('duck').cook()<cr>"},
        },
    },

    "m4xshen/autoclose.nvim",

    "tamago324/lir.nvim",

    "echasnovski/mini.bracketed",

    "JoosepAlviste/nvim-ts-context-commentstring",
    {
        "m4xshen/smartcolumn.nvim",
        opts = {
            colorcolumn = "80",
            disabled_filetypes = { "help", "text", "markdown" },
            custom_colorcolumn = {
                rust = "100",
                python = "100",
            },
        }
    },
})

-- Highlight yanked text
vim.cmd [[autocmd TextYankPost * silent! lua require"vim.highlight".on_yank()]]

vim.cmd [[
tnoremap <C-H> <C-\><C-n>

imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

nmap <C-s>h <Plug>(vsnip-select-text)
nmap <C-s>j <Plug>(vsnip-cut-text)

" Highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=#FF4060
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red
autocmd InsertEnter * match ExtraWhiteSpace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhiteSpace /\s\+$/

" CPP
" Ändra till editorconfig!!!!
autocmd FileType cpp setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript set shiftwidth=2
" Makefiles should use tabulators
autocmd FileType make setlocal shiftwidth=4 tabstop=4 noexpandtab

" Disable syntax for large files
let g:LargeFile = 1024 * 1024 * 5
augroup LargeFile
 autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function LargeFile()
 " no syntax highlighting etc
 set eventignore+=FileType
 setlocal bufhidden=unload
 setlocal undolevels=-1
 " display message
 autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction

inoremap <A-h> <C-o>h
inoremap <A-j> <C-o>j
inoremap <A-k> <C-o>k
inoremap <A-l> <C-o>l

nmap <silent> <A-h> :wincmd h<CR>
nmap <silent> <A-j> :wincmd j<CR>
nmap <silent> <A-k> :wincmd h<CR>
nmap <silent> <A-l> :wincmd l<CR>

" Navigation
nmap . .`[
nmap j gj
nmap k gk
nmap <c-h> :ClangdSwitchSourceHeader<CR>
nmap <F3> :e ~/.config/nvim/lua/init.lua <CR>
nmap <F4> :e ~/.config/nvim/init.vim <CR>
nmap <F5> <cmd> lua require'lir.float'.toggle()<CR>
nmap <F12> :tjump <C-R><C-W> <CR>

noremap <leader>j "+y
noremap <leader>k "+p
noremap <leader>J "*y
noremap <leader>K "*p

nmap <script> <silent> <leader>ö :TroubleToggle<CR>
nmap <script> <silent> <leader>r :TroubleToggle lsp_references<CR>
nmap <script> <silent> <leader>s :SymbolsOutline<CR>

nmap <F7> :CellularAutomaton make_it_rain<CR>

" Change between indentation settings
nmap <F9> :set tabstop=4<CR>:set shiftwidth=4<CR>:set expandtab<CR>:set cinoptions=<CR>
nmap <F10> :set tabstop=2<CR>:set shiftwidth=2<CR>:set expandtab<CR>:set cinoptions=<CR>

" For easier searching
nnoremap - /
nnoremap _ ?

" Highlight yanked text
augroup LuaHighlight
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

" Reset blinking mode when leaving
au VimLeave * set guicursor=a:block-blinkon1
au VimSuspend * set guicursor=a:block-blinkon1
au VimResume * set guicursor=a:block-blinkon0

let g:indent_blankline_show_current_context = v:true
let g:indent_blankline_use_treesitter = v:true

set omnifunc=v:lua.vim.lsp.omnifunc

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" Nvim LSP mappings
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> gx    <cmd>lua vim.lsp.buf.code_action()<CR>

" Diagnostics
nnoremap <silent> <leader>N      <cmd>lua vim.diagnostic.goto_next({float = {border="single"}})<CR>
nnoremap <silent> <leader>P      <cmd>lua vim.diagnostic.goto_prev({float = {border="single"}})<CR>
nnoremap <silent> <leader>n      <cmd>lua vim.diagnostic.goto_next({severity= vim.diagnostic.severity.ERROR, float = {border="single"}})<CR>
nnoremap <silent> <leader>p      <cmd>lua vim.diagnostic.goto_prev({severity= vim.diagnostic.severity.ERROR, float = {border="single"}})<CR>
nnoremap <silent> <leader>i      <cmd>lua vim.diagnostic.open_float({ border = "single" })<CR>
nnoremap <silent> <leader>G      <cmd>:Rg<CR>
nnoremap <silent> <leader>q      <cmd>:NvimTreeToggle<CR>

nnoremap <silent> gw    <cmd>HopWord<CR>
nnoremap <silent> gl    <cmd>HopLine<CR>

" Telescope mappings
nnoremap <leader>g :lua require'telescope.builtin'.live_grep{}<cr>
nnoremap <leader>x :lua require'telescope.builtin'.lsp_code_actions{}<cr>
nnoremap <leader>f :lua require'telescope.builtin'.lsp_dynamic_workspace_symbols{}<cr>
nnoremap <leader>d :lua require'telescope.builtin'.lsp_document_symbols{}<cr>
nnoremap <leader>z :lua require'telescope.builtin'.current_buffer_fuzzy_find{}<cr>

nmap <C-K> :Buffers<CR>
nmap <C-L> :BTags<CR>
nmap <C-G> :BLines<CR>
nmap <C-J> :GFiles<CR>
nmap <C-N> :GFiles?<CR>
nmap <C-P> :Files<CR>

" Reset blinking mode when leaving
if has('nvim')
    let $FZF_DEFAULT_OPTS='--layout=reverse --margin=1,3'
    let g:fzf_layout = { 'window': 'call FloatingFZF()' }
    function! FloatingFZF()
        let buf = nvim_create_buf(v:false, v:true)
        call setbufvar(buf, '&signcolumn', 'no')
        let height = float2nr(40)
        let width = float2nr(140)
        let horizontal = float2nr((&columns - width) / 2)
        let vertical = 1

        let opts = {
                    \ 'relative': 'editor',
                    \ 'row': vertical,
                    \ 'col': horizontal,
                    \ 'width': width,
                    \ 'height': height,
                    \ 'style': 'minimal'
                    \ }
        call nvim_open_win(buf, v:true, opts)
    endfunction
endif

function! CreateCenteredFloatingWindow()
    let width = min([&columns - 20, max([80, &columns - 20])])
    let height = min([&lines - 10, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

if exists("g:neovide")
    " Put anything you want to happen only in Neovide here
    set guifont=UbuntuMono\ Nerd\ Font\ Mono:h13
    " set guifont=RobotoMono\ Nerd\ Font\ Mono:h9.3
    let g:neovide_refresh_rate=140
    let g:neovide_cursor_animation_length=0.01
    let g:neovide_cursor_trail_length=0.001
    let g:neovide_floating_blur_amount_x = 2.0
    let g:neovide_floating_blur_amount_y = 2.0
    let g:neovide_transparency = 0.6
endif

" move.nvim
nnoremap <silent> <A-j> :MoveLine(1)<CR>
nnoremap <silent> <A-k> :MoveLine(-1)<CR>
vnoremap <silent> <A-j> :MoveBlock(1)<CR>
vnoremap <silent> <A-k> :MoveBlock(-1)<CR>

let g:matchparen_timeout = 100
let g:matchparen_insert_timeout = 100

hi string cterm=italic gui=italic
"
set cursorline
hi cursorline cterm=none term=none
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
highlight CursorLine guibg=#222222 ctermbg=234
highlight ColorColumn guibg=#443333
highlight Search guibg=#aa4444 guifg=#111111
highlight Pmenu guibg=#222222
highlight FloatNormal guibg=#ffffff
]]

