local conf = require("plugins.edit.configs")
local plugins = {
    -- 语法高亮显示
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        requires = {
            "p00f/nvim-ts-rainbow", -- 彩虹括号
            -- 提供"commentstring"设置。它不添加任何用于注释的映射。配合Comment.nvim一起使用
            "JoosepAlviste/nvim-ts-context-commentstring", -- 注释
        },
        config = conf.nvim_treesitter,
    },

    {
        "numToStr/Comment.nvim",
        config = conf.comment,
    },

    {
        "windwp/nvim-autopairs",
        -- after = "nvim-cmp",
        config = conf.nvim_autopairs,
    },
}


return plugins
