local conf = require("plugins.completion.configs")
local plugins = {
    -- Neovim内置语言服务器客户端的公共配置集合。
    -- 这个插件允许以声明的方式配置、启动和初始化安装在系统上的语言服务器。
    {
        "neovim/nvim-lspconfig", -- Collection of configurations for the built-in LSP client
        config = conf.nvim_lspconfig,
    },

    {
        "williamboman/nvim-lsp-installer", -- Collection of configurations for the built-in LSP client
        after = "nvim-lspconfig",
        config = conf.nvim_lsp_installer,
    },

    {
        "tami5/lspsaga.nvim",
        after = "nvim-lspconfig",
        config = conf.lspsaga,
    },

    {
        "ray-x/lsp_signature.nvim",
        config = conf.lsp_signature,
    },

    {
        "L3MON4D3/LuaSnip",
        config = conf.LuaSnip,
        -- 安装类似于vcode的使用插件中现有的vs-code风格片段的插件
        requires = "rafamadriz/friendly-snippets",
    },

    {
        "hrsh7th/nvim-cmp",
        config = conf.nvim_cmp,
        -- event = "InsertEnter",
        requires = {
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-nvim-lua" },
            { "lukas-reineke/cmp-under-comparator" },


        }
    },

    {
        "onsails/lspkind.nvim",
        config = conf.lspkind,
    },

}


return plugins
