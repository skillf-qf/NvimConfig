

local packer_compiled = "~/.local/share/nvim/site/lua/packer_compiled.lua"

local nvim_start = function()
    -- 加载配置项
    require("conf.settings")
    require("conf.pack")
    require("conf.keymap")

    -- 存在则加载编译文件
    if vim.fn.filereadable(vim.fn.expand(packer_compiled)) == 1 then
        require("packer_compiled")
    end

    -- 应用 catppuccin 主题
    vim.cmd([[colorscheme catppuccin]])
    --vim.cmd([[set guifont=Fira\ Code\ Regular\ Nerd\ Font:h12]])
    --vim.o.guifont = "Fira\ Code\ Regular\ Nerd\ Font:h12"
end

nvim_start()
