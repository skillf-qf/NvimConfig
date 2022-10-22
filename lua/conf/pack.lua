
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
local packer = require("packer")
-- 使用本地变量use绑定packer.use()打包器函数来声明插件
local use = packer.use

local function load_plugins(s)
    local plugins = require(s)
    for _, v in ipairs(plugins) do
        use(v)
    end
end

local function plugins()
    -- 包管理器
    use {
        "wbthomason/packer.nvim"
    }
    -- 多数插件依赖库
    use {
        "nvim-lua/plenary.nvim"
    }
    -- vim-devicons的lua分支。这个插件提供了相同的图标以及每个图标的颜色
    use {
        "kyazdani42/nvim-web-devicons"
    }

    -- 主题
    load_plugins("plugins.theme.plugins")
    -- 编辑
    load_plugins("plugins.edit.plugins")
    -- 自动补全
    load_plugins("plugins.completion.plugins")
    -- 工具
    load_plugins("plugins.tool.plugins")

end


packer.startup(
    {
        -- function主体而不是运行function()
        plugins,
        config = {
            -- 设置编译packer.nvim代码输出文件的存放路径
            -- 如果为nil则在～/.config/nvim/plugin/packer_compiled.lua
            compile_path = "~/.local/share/nvim/site/lua/packer_compiled.lua",
            display = {
                open_fn = function()
                    return require('packer.util').float({ border = 'single' })
                end
            }
        }
    }
)
-- 实时生效配置
--vim.cmd(
--    [[
--  augroup packer_user_config
--    autocmd!
--    autocmd BufWritePost pack.lua source <afile> | PackerCompile
--  augroup end
--]]
--)
