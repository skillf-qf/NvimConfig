local config = {}


function config.nvim_lspconfig()

    -- Borders
    -- 必须使用autocmd设置高亮显示组，以避免被配色方案覆盖
    vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
    vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]
    -- Floating windows with borders are built-into the neovim core handler.
    -- The borders can be styled by passing in a character and highlight group.
    local border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
    }
    -- LSP settings (for overriding per client)
    local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
    }
    -- To instead override globally
    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or border
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end

    -- Customizing how diagnostics are displayed
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
        -- underline:(默认为true)使用下划线进行诊断。可选: severity:只在匹配指定严重性diagnostic-severity的诊断下显示划线
        underline = true,
        -- 在插入模式下是否也显示诊断
        update_in_insert = false,
        -- 诊断的虚拟文本，prefix可选项：'●', '▎', 'x'
        -- source: "always" 总是显示诊断信息来源
        virtual_text = { spacing = 5, prefix = "●", source = "always", severity_limit = "Warning" },
        -- 根据级别对诊断信息进行排序。这会影响符号和虚拟文本的显示顺序。
        -- 当为true时，较高的严重性显示在较低的严重性之前(例如:在WARN前显示ERROR)。
        -- severity_sort.reverse:(boolean)反向排序
        severity_sort = true,
        float = { source = "always", }, -- Or "if_many"
    })

    -- Change diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- Show line diagnostics automatically in hover window
    -- You will likely want to reduce updatetime which affects CursorHold
    -- note: this setting is global and should be set only once
    -- vim.o.updatetime = 100
    -- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]



end

function config.nvim_lsp_installer()

    local lsp_installer = require("nvim-lsp-installer")


    -- Add additional capabilities supported by nvim-cmp
    -- cmp_nvim_lsp: hrsh7th/cmp-nvim-lsp 这是nvim-cmp的LSP类中的补全源之一，需要在nvim-cmp配置文件的源列表参数中指定
    -- 在这里需要使用capabilities来更新替换掉内置的 'omnifunc( vim.lsp.omnifunc() )'
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

    -- 重写lspconfig中的on_attach按键映射函数
    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(_, bufnr)

        local lsp_key_maps = require("conf.keymap")
        -- 对 "lsp-buf" 功能函数的按键映射.
        lsp_key_maps.lsp_key_mapping(bufnr)

    end


    -- Include the servers you want to have installed by default below
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    -- 配置servers列表，包含需要安装的语言服务器
    local servers = {
        "bashls", -- Bash
        "clangd", -- C/C++
        "pyright", -- Python
        "sumneko_lua", -- Lua
        "zeta_note", -- Markdown
        "yamlls", -- YAML
        "jsonls", -- JSON
    }

    -- 调用nvim-lsp-installer安装函数统一安装servers列表中的语言服务器
    for _, name in pairs(servers) do
        local server_is_found, server = lsp_installer.get_server(name)
        if server_is_found and not server:is_installed() then
            print("Installing " .. name)
            server:install()
        end
    end

    -- 覆盖servers列表中的某些语言服务器的设置
    local enhance_server_opts = {
        -- Provide settings that should only apply to the "sumneko_lua" server
        ["sumneko_lua"] = function(opts)
            opts.settings = {
                Lua = {
                    -- Get the language server to recognize the `vim` global
                    diagnostics = { globals = { 'vim' } },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = {
                            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                        },
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = { enable = false },
                },
            }
        end,
    }

    -- 统一设置servers列表中的语言服务器，使其生效
    lsp_installer.on_server_ready(function(server)
        -- Specify the default options which we'll use to setup all servers
        local opts = {
            on_attach = on_attach,
            -- 开启nvim-cmp补全功能
            capabilities = capabilities,
        }

        if enhance_server_opts[server.name] then
            -- Enhance the default opts with the server-specific ones
            enhance_server_opts[server.name](opts)
        end

        server:setup(opts)
    end)

    -- 根据自身需求修改nvim-lsp-installer 的ui
    lsp_installer.settings({
        ui = {
            icons = {
                server_installed = "✓",
                server_pending = "➜",
                server_uninstalled = "✗"
            }
        }
    })

end


function config.lspsaga()

    local lspsaga = require("lspsaga")
    lspsaga.setup { -- defaults ...
        debug = false,
        use_saga_diagnostic_sign = true,
        -- diagnostic sign
        error_sign = "",
        warn_sign = "",
        hint_sign = "",
        infor_sign = "",
        diagnostic_header_icon = "   ",
        -- code action title icon
        code_action_icon = " ",
        code_action_prompt = {
            enable = true,
            sign = true,
            sign_priority = 40,
            virtual_text = true,
        },
        finder_definition_icon = "  ",
        finder_reference_icon = "  ",
        max_preview_lines = 10,
        finder_action_keys = {
            open = "o",
            vsplit = "s",
            split = "i",
            quit = "q",
            scroll_down = "<C-f>",
            scroll_up = "<C-b>",
        },
        code_action_keys = {
            quit = "q",
            exec = "<CR>",
        },
        rename_action_keys = {
            quit = "<C-c>",
            exec = "<CR>",
        },
        definition_preview_icon = "  ",
        -- round、single、double
        border_style = "round",
        rename_prompt_prefix = "➤",
        rename_output_qflist = {
            enable = true,
            auto_open_qflist = true,
        },
        server_filetype_map = {},
        diagnostic_prefix_format = "%d. ",
        diagnostic_message_format = "%m %c",
        -- 高亮诊断弹窗中的错误关键词
        highlight_prefix = false,
    }

end


function config.lsp_signature()

    require "lsp_signature".setup({
        -- This is mandatory, otherwise border config won't get registered.
        bind = true,
        -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
        -- set to 0 if you DO NOT want any API comments be shown
        -- This setting only take effect in insert mode, it does not affect signature help in normal
        -- mode, 10 by default
        oc_lines =10,
        -- show hint in a floating window, set to false for virtual text only mode
        -- true: 插入模式输入时自动触发
        -- false: 需要给"toggle_key" 设置触发按键
        floating_window = true,
        -- set to true, the floating window will not auto-close until finish all parameters
        fix_pos = false,
        -- virtual hint enable
        hint_enable = true,
        -- how your parameter will be highlight
        hi_parameter = "LspSignatureActiveParameter",
        -- max height of signature floating_window, if content is more than max_height, you can scroll down
        -- to view the hiding contents
        max_height = 12,
        -- max_width of signature floating_window, line will be wrapped if exceed max_width
        max_width = 80,
        -- double, rounded, single, shadow, none
        handler_opts = { border = "rounded" },
        -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
        toggle_key = nil,
    })



end


function config.LuaSinp()

    local ls = require("luasnip")
    ls.config.set_config({
        -- If true, Snippets that were exited can still be jumped back into.
        -- As Snippets are not removed when their text is deleted, they have to be removed manually via 'LuasnipUnlinkCurrent' if 'delete_check_events' is not enabled (set to eg. 'TextChanged').
        history = true,
        -- Choose which events trigger an update of the active nodes' dependents.
        -- Default is just 'InsertLeave', 'TextChanged,TextChangedI' would update on every change.
        update_events = 'TextChanged,TextChangedI',
    })

    -- You can also use lazy loading so snippets are loaded on-demand, not all at once (may interfere with lazy-loading luasnip itself).
    -- 从插件 requires = "rafamadriz/friendly-snippets" 中加载VSCode风格的代码片段补全
    require("luasnip.loaders.from_vscode").lazy_load() -- You can pass { paths = "./my-snippets/"} as well


end

function config.nvim_cmp()

    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    local cmp = require('cmp')

    -- Setup nvim-cmp.
    cmp.setup({
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
        window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s" }),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
        }),

        formatting = {
            format = lspkind.cmp_format({
                mode = "symbol_text",
                menu = ({
                    buffer = "[BUFFER]",
                    nvim_lsp = "[LSP]",
                    luasnip = "[LUASNIP]",
                    nvim_lua = "[NVIM]",
                    path = "[PATH]",
                })
            }),
        },

        sorting = {
            comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.score,
                require("cmp-under-comparator").under,
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },


        -- List of sources
        sources = {
            -- Snippets
            { name = 'luasnip' }, -- saadparwaiz1/cmp_luasnip (For luasnip users.)

            -- LSP
            { name = 'nvim_lsp' }, -- hrsh7th/cmp-nvim-lsp 替换掉内置的'vim.lsp.omnifunc()'

            -- Shell

            -- Filesystem paths
            { name = 'path' }, -- hrsh7th/cmp-path

            -- Command line
            { name = 'cmdline' }, -- hrsh7th/cmp-cmdline

            -- Buffer
            { name = 'buffer' }, -- hrsh7th/cmp-buffer

            -- Neovim's Lua API
            { name = 'nvim_lua' }, -- hrsh7th/cmp-nvim-lua




        },

    })

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
            { name = 'cmdline' },
        })
    })





end


function config.lspkind()

    local lspkind = require("lspkind")

    lspkind.init({
        -- DEPRECATED (use mode instead): enables text annotations
        --
        -- default: true
        -- with_text = true,

        -- defines how annotations are shown
        -- default: symbol
        -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
        mode = 'symbol_text',

        -- default symbol map
        -- can be either 'default' (requires nerd-fonts font) or
        -- 'codicons' for codicon preset (requires vscode-codicons font)
        --
        -- default: 'default'
        preset = 'codicons',

        -- override preset symbols
        --
        -- default: {}
        symbol_map = {
            Text = "",
            Method = "",
            Function = "",
            Constructor = "",
            Field = "ﰠ",
            Variable = "",
            Class = "ﴯ",
            Interface = "",
            Module = "",
            Property = "ﰠ",
            Unit = "塞",
            Value = "",
            Enum = "",
            Keyword = "",
            Snippet = "",
            Color = "",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = "פּ",
            Event = "",
            Operator = "",
            TypeParameter = ""
        },

    })

end




return config
