


-- vim.o:
--     Get or set editor options, like |:set|. Invalid key is an error.

-- 自动缩进的策略为 plugin
vim.o.filetype = "plugin"
-- 是否特殊显示空格等字符
vim.o.list = true
-- 用于'list'模式和|:list|命令的字符串。
vim.o.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←"
-- 显示绝对行号
vim.o.number = true
-- 显示相对行号
vim.o.relativenumber = true
-- 在Terminal UI中启用24位RGB颜色支持
vim.o.termguicolors = true
-- 内部使用的字符编码方式，包括 Vim 的 buffer (缓冲区)、菜单文本、消息文本等
vim.o.encoding = "utf-8"
-- 开启鼠标支持，"a"：所有模式
vim.o.mouse = "a"
-- 分割窗口时，新窗口是否放置于右边
-- 注意: 这里需要配合使用的文件目录管理器(nvim-tree) 放置左侧还是右侧
-- 左侧：应该设为 true
-- 右侧：应该设为 false
vim.o.splitright = true
-- vim.g:
--     Global (|g:|) editor variables. Key with no value returns `nil`.

-- 设置Leader键
vim.g.mapleader = ' '



