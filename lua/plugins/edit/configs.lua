
local config = {}

function config.nvim_treesitter()
    require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
        -- 安装已支持高亮的语言 ”:TSInstall <language_to_install>“
        -- 查看已安装的语言 ”:TSInstallInfo“
        --ensure_installed = "all",
        ensure_installed = { "bash", "c", "python", "lua", "make", "markdown" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        --sync_install = true,

        -- List of parsers to ignore installing (for "all")
        --ignore_install = { "javascript" },

        highlight = {
            -- `false` will disable the whole extension
            enable = true,

            -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
            -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
            -- the name of the parser)
            -- list of language that will be disabled
            --disable = { "c", "rust" },

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },

        -- indent have bug in python
        --indent = {
        --    enable = false
        --},

        -- p00f/nvim-ts-rainbow
        rainbow = {
            enable = true,
            -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
            extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
            --max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
            -- colors = {}, -- table of hex strings
            -- termcolors = {} -- table of colour name strings
        },

        -- JoosepAlviste/nvim-ts-context-commentstring
        context_commentstring = {
            enable = true,
            enable_autocmd = false,
            --config = {
            --    css = '// %s'
            --}
        },
    }
end

function config.comment()
    -- local comment_string = require("ts_context_commentstring")
    require('Comment').setup {
        ---Add a space b/w comment and the line
        ---@type boolean|fun():boolean
        --padding = true,

        ---Whether the cursor should stay at its position
        ---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
        ---@type boolean
        --sticky = true,

        ---Lines to be ignored while comment/uncomment.
        ---Could be a regex string or a function that returns a regex string.
        ---Example: Use '^$' to ignore empty lines
        ---@type string|fun():string
        --ignore = nil,

        ---LHS of toggle mappings in NORMAL + VISUAL mode
        ---@type table
        toggler = {
            ---Line-comment toggle keymap
            line = 'gcc',
            ---Block-comment toggle keymap
            block = 'gbc',
        },

        ---LHS of operator-pending mappings in NORMAL + VISUAL mode
        ---@type table
        opleader = {
            ---Line-comment keymap
            line = 'gc',
            ---Block-comment keymap
            block = 'gb',
        },

        ---LHS of extra mappings
        ---@type table
        extra = {
            ---Add comment on the line above
            above = 'gcO',
            ---Add comment on the line below
            below = 'gco',
            ---Add comment at the end of line
            eol = 'gcA',
        },

        ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
        ---NOTE: If `mappings = false` then the plugin won't create any mappings
        ---@type boolean|table
        --mappings = {
        --    ---Operator-pending mapping
        --    ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
        --    ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
        --    basic = true,
        --    ---Extra mapping
        --    ---Includes `gco`, `gcO`, `gcA`
        --    extra = true,
        --    ---Extended mapping
        --    ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
        --    extended = false,
        --},

        ---Post-hook, called after commenting is done
        ---@type fun(ctx: Ctx)
        --post_hook = nil,

        ---Pre-hook, called before commenting the line
        ---@type fun(ctx: Ctx):string
        ---@param ctx Ctx
        pre_hook = function(ctx)
            -- Only calculate commentstring for tsx filetypes
            if vim.bo.filetype == 'typescriptreact' then
                local U = require('Comment.utils')

                -- Determine whether to use linewise or blockwise commentstring
                local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'

                -- Determine the location where to calculate commentstring from
                local location = nil
                if ctx.ctype == U.ctype.block then
                    location = require('ts_context_commentstring.utils').get_cursor_location()
                elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                    location = require('ts_context_commentstring.utils').get_visual_start_location()
                end

                return require('ts_context_commentstring.internal').calculate_commentstring({
                    key = type,
                    location = location,
                })
            end
        end,

    }
end


function config.nvim_autopairs()
    require("nvim-autopairs").setup()
end

return config
