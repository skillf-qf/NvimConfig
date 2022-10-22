local conf = require("plugins.theme.configs")
local plugins = {
    -- NeoVim的柔和主题
    -- https://github.com/catppuccin/nvim
    {
        "catppuccin/nvim",
        as = "catppuccin",
        config = conf.catppuccin,
    },

    -- 用lua编写的neovim文件资源管理器树
    -- https://github.com/kyazdani42/nvim-tree.lua
    {
        "kyazdani42/nvim-tree.lua",
        config = conf.nvim_tree,
    },

    -- buffer line (with tabpage integration) for Neovim built using lua.
    {
        "akinsho/bufferline.nvim",
        config = conf.bufferline,
    },

    -- 炫酷的状态栏插件
    -- {
    --     "windwp/windline.nvim",
    --     config = conf.windline,
    -- },
    {
        "glepnir/galaxyline.nvim",
        config = conf.galaxyline,
    },

}


return plugins
