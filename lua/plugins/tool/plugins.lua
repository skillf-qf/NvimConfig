local conf = require("plugins.tool.configs")
local plugins = {
    -- NeoVim的柔和主题
    -- https://github.com/catppuccin/nvim
    {
        "nvim-telescope/telescope.nvim",
        config = conf.telescope,
    },

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = 'make',
    },
}


return plugins
