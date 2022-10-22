
local config = {}

function config.catppuccin()
    require("catppuccin").setup({
        transparent_background = false,
        term_colors = false,
        styles = {
            comments = "italic",
            functions = "italic,bold",
            keywords = "italic",
            strings = "NONE",
            variables = "NONE",
        },
        integrations = {
            treesitter = true,
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = "italic",
                    hints = "italic",
                    warnings = "italic",
                    information = "italic",
                },
                underlines = {
                    errors = "underline",
                    hints = "underline",
                    warnings = "underline",
                    information = "underline",
                },
            },
            lsp_trouble = true,
            --cmp = true,
            lsp_saga = true,
            gitgutter = false,
            gitsigns = true,
            telescope = true,
            nvimtree = {
                enabled = true,
                show_root = true,
                --transparent_panel = false,
            },
            --neotree = {
            --	enabled = false,
            --	show_root = false,
            --	transparent_panel = false,
            --},
            which_key = true,
            indent_blankline = {
                enabled = true,
                colored_indent_levels = false,
            },
            dashboard = true,
            neogit = false,
            vim_sneak = false,
            fern = false,
            barbar = false,
            bufferline = true,
            markdown = true,
            lightspeed = false,
            ts_rainbow = true,
            hop = true,
            --notify = true,
            --telekasten = true,
            --symbols_outline = true,
        },
    })

    -- 插件加载完之后才能应用主题
    --vim.cmd([[colorscheme catppuccin]])
end


function config.nvim_tree()

    require("nvim-tree").setup {
        auto_reload_on_write = true,
        disable_netrw = false,
        hijack_cursor = false,
        hijack_netrw = true,
        hijack_unnamed_buffer_when_opening = false,
        ignore_buffer_on_setup = false,
        open_on_setup = false,
        open_on_setup_file = false,
        open_on_tab = false,
        sort_by = "name",
        update_cwd = false,
        view = {
            width = 30,
            height = 30,
            hide_root_folder = false,
            side = "left", -- 应该配合 vim.o.splitright = true
            preserve_window_proportions = false,
            number = false,
            relativenumber = false,
            signcolumn = "yes",
            mappings = {
                custom_only = false,
                list = {
                  -- user mappings go here
                },
            },
        },
        renderer = {
            indent_markers = {
              enable = false,
              icons = {
                corner = "└ ",
                edge = "│ ",
                none = "  ",
              },
            },
            icons = {
                webdev_colors = true,
            },
        },
        hijack_directories = {
            enable = true,
            auto_open = true,
        },
        update_focused_file = {
            enable = true,
            update_cwd = true,
            ignore_list = {},
        },
        ignore_ft_on_setup = {},
        system_open = {
            cmd = "",
            args = {},
        },
        diagnostics = {
            enable = true,
            show_on_dirs = true,
            icons = {
              hint = "",
              info = "",
              warning = "",
              error = "",
            },
        },
        filters = {
            dotfiles = false,
            custom = {},
            exclude = {},
        },
        git = {
            enable = true,
            ignore = true,
            timeout = 400,
        },
        actions = {
            use_system_clipboard = true,
            change_dir = {
                enable = true,
                global = false,
                restrict_above_cwd = false,
            },
            open_file = {
                quit_on_open = false,
                resize_window = true,
                window_picker = {
                    enable = true,
                    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                    exclude = {
                        filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                        buftype = { "nofile", "terminal", "help" },
                    },
                },
            },
        },
        trash = {
            cmd = "trash",
            require_confirm = true,
        },
        log = {
            enable = false,
            truncate = false,
            types = {
                all = false,
                config = false,
                copy_paste = false,
                diagnostics = false,
                git = false,
                profile = false,
            },
        },
    }

end

function config.bufferline()
    local bufferline = require("bufferline")

    bufferline.setup {
        options = {
            -- 为每个 buffer 都配置一个序数
            numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
            max_name_length = 18,
            max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
            tab_size = 18,
            -- 使用 nvim_lsp 进行诊断
            diagnostics = "nvim_lsp", -- "false" | "nvim_lsp" | "coc",
            -- 显示诊断信息数量与对应图标
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                local s = " "
                for e, n in pairs(diagnostics_dict) do
                    local sym = e == "error" and " " or (e == "warning" and " " or "")
                    s = s .. n .. sym
                end
                return s
            end,

            -- 分割符样式："slant" | "thick" | "thin"
            -- 如果是透明背景，不推荐使用 slant
            separator_style = "thin",
            -- Sidebar offset
            offsets = {
                {filetype = "NvimTree", text = "File Explorer", text_align = "center"},
            },

        }
    }

end


function config.galaxyline()
    local gl = require('galaxyline')
    local colors = require('galaxyline.theme').default
    local condition = require('galaxyline.condition')
    local gls = gl.section
    gl.short_line_list = {'NvimTree','vista','dbui','packer'}

    gls.left[1] = {
        RainbowRed = {
            provider = function() return '▊ ' end,
            highlight = {colors.blue,colors.bg}
        },
    }
    gls.left[2] = {
        ViMode = {
            provider = function()
                -- auto change color according the vim mode
                local mode_color = {n = colors.red, i = colors.green,v=colors.blue,
                                    [''] = colors.blue,V=colors.blue,
                                    c = colors.magenta,no = colors.red,s = colors.orange,
                                    S=colors.orange,[''] = colors.orange,
                                    ic = colors.yellow,R = colors.violet,Rv = colors.violet,
                                    cv = colors.red,ce=colors.red, r = colors.cyan,
                                    rm = colors.cyan, ['r?'] = colors.cyan,
                                    ['!']  = colors.red,t = colors.red}
                vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()] ..' guibg='..colors.bg)
                return '  '
            end,
        },
    }
    gls.left[3] = {
      FileSize = {
        provider = 'FileSize',
        condition = condition.buffer_not_empty,
        highlight = {colors.fg,colors.bg}
      }
    }
    gls.left[4] ={
      FileIcon = {
        provider = 'FileIcon',
        condition = condition.buffer_not_empty,
        highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.bg},
      },
    }

    gls.left[5] = {
      FileName = {
        provider = 'FileName',
        condition = condition.buffer_not_empty,
        highlight = {colors.fg,colors.bg,'bold'}
      }
    }

    gls.left[6] = {
      LineInfo = {
        provider = 'LineColumn',
        separator = ' ',
        separator_highlight = {'NONE',colors.bg},
        highlight = {colors.fg,colors.bg},
      },
    }

    gls.left[7] = {
      PerCent = {
        provider = 'LinePercent',
        separator = ' ',
        separator_highlight = {'NONE',colors.bg},
        highlight = {colors.fg,colors.bg,'bold'},
      }
    }

    gls.left[8] = {
      DiagnosticError = {
        provider = 'DiagnosticError',
        icon = '  ',
        highlight = {colors.red,colors.bg}
      }
    }

    gls.left[9] = {
      DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        icon = '  ',
        highlight = {colors.yellow,colors.bg},
      }
    }

    gls.left[10] = {
      DiagnosticHint = {
        provider = 'DiagnosticHint',
        icon = '  ',
        highlight = {colors.cyan,colors.bg},
      }
    }

    gls.left[11] = {
      DiagnosticInfo = {
        provider = 'DiagnosticInfo',
        icon = '  ',
        highlight = {colors.blue,colors.bg},
      }
    }

    gls.mid[1] = {
      ShowLspClient = {
        provider = 'GetLspClient',
        condition = function ()
          local tbl = {['dashboard'] = true,['']=true}
          if tbl[vim.bo.filetype] then
            return false
          end
          return true
        end,
        icon = ' LSP:',
        highlight = {colors.yellow,colors.bg,'bold'}
      }
    }

    gls.right[1] = {
      FileEncode = {
        provider = 'FileEncode',
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = {'NONE',colors.bg},
        highlight = {colors.green,colors.bg,'bold'}
      }
    }

    gls.right[2] = {
      FileFormat = {
        provider = 'FileFormat',
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = {'NONE',colors.bg},
        highlight = {colors.green,colors.bg,'bold'}
      }
    }

    gls.right[3] = {
      GitIcon = {
        provider = function() return '  ' end,
        condition = condition.check_git_workspace,
        separator = ' ',
        separator_highlight = {'NONE',colors.bg},
        highlight = {colors.violet,colors.bg,'bold'},
      }
    }

    gls.right[4] = {
      GitBranch = {
        provider = 'GitBranch',
        condition = condition.check_git_workspace,
        highlight = {colors.violet,colors.bg,'bold'},
      }
    }

    gls.right[5] = {
      DiffAdd = {
        provider = 'DiffAdd',
        condition = condition.hide_in_width,
        icon = '  ',
        highlight = {colors.green,colors.bg},
      }
    }

    gls.right[6] = {
      DiffModified = {
        provider = 'DiffModified',
        condition = condition.hide_in_width,
        icon = ' 柳',
        highlight = {colors.orange,colors.bg},
      }
    }

    gls.right[7] = {
      DiffRemove = {
        provider = 'DiffRemove',
        condition = condition.hide_in_width,
        icon = '  ',
        highlight = {colors.red,colors.bg},
      }
    }

    gls.right[8] = {
      RainbowBlue = {
        provider = function() return ' ▊' end,
        highlight = {colors.blue,colors.bg}
      },
    }

    gls.short_line_left[1] = {
      BufferType = {
        provider = 'FileTypeName',
        separator = ' ',
        separator_highlight = {'NONE',colors.bg},
        highlight = {colors.blue,colors.bg,'bold'}
      }
    }

    gls.short_line_left[2] = {
      SFileName = {
        provider =  'SFileName',
        condition = condition.buffer_not_empty,
        highlight = {colors.fg,colors.bg,'bold'}
      }
    }

    gls.short_line_right[1] = {
      BufferIcon = {
        provider= 'BufferIcon',
        highlight = {colors.fg,colors.bg}
      }
    }


end

function config.windline()
    local windline = require('windline')
    local effects = require('wlanimation.effects')
    local HSL = require('wlanimation.utils')
    require('wlsample.airline')
    local animation = require('wlanimation')

    local is_run = false

    local function toggle_anim()
        if is_run then
            animation.stop_all()
            is_run = false
            return
        end
        is_run = true
        local magenta_anim={}
        local yellow_anim={}
        local blue_anim = {}
        local green_anim={}
        local red_anim = {}
        local colors = windline.get_colors()

        if vim.o.background == 'light' then
            magenta_anim = HSL.rgb_to_hsl(colors.magenta):tints(10,8)
            yellow_anim = HSL.rgb_to_hsl(colors.yellow):tints(10,8)
            blue_anim = HSL.rgb_to_hsl(colors.blue):tints(10, 8)
            green_anim = HSL.rgb_to_hsl(colors.green):tints(10,8)
            red_anim = HSL.rgb_to_hsl(colors.red):tints(10,8)
        else
            -- shades will create array of color from color to black color .I don't need
            -- black color then I only take 8
            magenta_anim = HSL.rgb_to_hsl(colors.magenta):shades(10,8)
            yellow_anim = HSL.rgb_to_hsl(colors.yellow):shades(10, 8)
            blue_anim = HSL.rgb_to_hsl(colors.blue):shades(10, 8)
            green_anim = HSL.rgb_to_hsl(colors.green):shades(10, 8)
            red_anim = HSL.rgb_to_hsl(colors.red):shades(10, 8)
        end

        animation.stop_all()
        animation.animation({
            data = {
                { 'magenta_a', effects.list_color(magenta_anim, 3) },
                { 'magenta_b', effects.list_color(magenta_anim, 2) },
                { 'magenta_c', effects.list_color(magenta_anim, 1) },

                { 'yellow_a', effects.list_color(yellow_anim, 3) },
                { 'yellow_b', effects.list_color(yellow_anim, 2) },
                { 'yellow_c', effects.list_color(yellow_anim, 1) },

                { 'blue_a', effects.list_color(blue_anim, 3) },
                { 'blue_b', effects.list_color(blue_anim, 2) },
                { 'blue_c', effects.list_color(blue_anim, 1) },

                { 'green_a', effects.list_color(green_anim, 3) },
                { 'green_b', effects.list_color(green_anim, 2) },
                { 'green_c', effects.list_color(green_anim, 1) },

                { 'red_a', effects.list_color(red_anim, 3) },
                { 'red_b', effects.list_color(red_anim, 2) },
                { 'red_c', effects.list_color(red_anim, 1) },
            },

            timeout = nil,
            delay = 200,
            interval = 150,
        })
    end

    WindLine.airline_anim_toggle = toggle_anim

    -- make it run on startup
    vim.defer_fn(function()
        toggle_anim()
    end, 200)
end

return config
