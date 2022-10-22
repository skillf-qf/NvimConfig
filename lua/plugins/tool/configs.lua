
local config = {}

function config.telescope()

    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup{
        defaults = {
            -- Default configuration for telescope goes here:
            -- config_key = value,
            prompt_prefix = "  ",
            -- selection_caret = " ",
            selection_caret = "➜ ",
            path_display = { "absolute" },
            mappings = {
                i = {
                    ["<C-c>"] = actions.close,
                    ["<C-Down>"] = actions.cycle_history_next,
                    ["<C-Up>"] = actions.cycle_history_prev,
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<Down>"] = actions.move_selection_next,
                    ["<Up>"] = actions.move_selection_previous,
                },

                n = {
                    ["<ESC>"] = actions.close,
                    ["<C-Down>"] = actions.cycle_history_next,
                    ["<C-Up>"] = actions.cycle_history_prev,
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<Down>"] = actions.move_selection_next,
                    ["<Up>"] = actions.move_selection_previous,
                }
            }
        },
        pickers = {
            -- Default configuration for builtin pickers goes here:
            -- picker_name = {
            --   picker_config_key = value,
            --   ...
            -- }
            -- Now the picker_config_key will be applied every time you call this
            -- builtin picker
        },
        extensions = {
            fzf = {
                fuzzy = true,                       -- false will only do exact matching
                override_generic_sorter = true,     -- override the generic sorter
                override_file_sorter = true,        -- override the file sorter
                case_mode = "smart_case",           -- or "ignore_case" or "respect_case"
                                                    -- the default case_mode is "smart_case"
            }
        }
    }

    -- Make the extensions load and work
    telescope.load_extension('fzf')


end

return config
