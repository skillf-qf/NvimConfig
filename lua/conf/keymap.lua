
local function set_keymap(...)
    vim.api.nvim_set_keymap(...)
end

local opts = { noremap = true, silent = true }

-- NvimTree
set_keymap("n", "<leader>1", ":NvimTreeToggle<CR>" ,opts)


-- bufferline
-- https://github.com/akinsho/bufferline.nvim
-- These commands will navigate through buffers in order regardless of which mode you are using
-- e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
set_keymap("n", "b]", ":BufferLineCycleNext<CR>" ,opts)
set_keymap("n", "b[", ":BufferLineCyclePrev<CR>" ,opts)

-- These commands will move the current buffer backwards or forwards in the bufferline
set_keymap("n", "B]", ":BufferLineMoveNext<CR>" ,opts)
set_keymap("n", "B[", ":BufferLineMovePrev<CR>" ,opts)

-- These commands will sort buffers by directory, language, or a custom criteria
set_keymap("n", "be", ":BufferLineSortByExtension<CR>" ,opts)
set_keymap("n", "bd", ":BufferLineSortByDirectory<CR>" ,opts)

set_keymap("n", "<M-1>", ":BufferLineGoToBuffer 1<CR>", opts)
set_keymap("n", "<M-2>", ":BufferLineGoToBuffer 2<CR>", opts)
set_keymap("n", "<M-3>", ":BufferLineGoToBuffer 3<CR>", opts)
set_keymap("n", "<M-4>", ":BufferLineGoToBuffer 4<CR>", opts)
set_keymap("n", "<M-5>", ":BufferLineGoToBuffer 5<CR>", opts)
set_keymap("n", "<M-6>", ":BufferLineGoToBuffer 6<CR>", opts)
set_keymap("n", "<M-7>", ":BufferLineGoToBuffer 7<CR>", opts)
set_keymap("n", "<M-8>", ":BufferLineGoToBuffer 8<CR>", opts)
set_keymap("n", "<M-9>", ":BufferLineGoToBuffer 9<CR>", opts)

-- telescope
-- https://github.com/nvim-telescope/telescope.nvim
set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
set_keymap("n", "<leader>fl", ":Telescope live_grep<CR>", opts)
set_keymap("n", "<leader>fg", ":Telescope grep_string<CR>", opts)
set_keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
set_keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
set_keymap("n", "<leader>fd", ":Telescope diagnostics<CR>", opts)
set_keymap("n", "<leader>fk", ":Telescope keymaps<CR>", opts)






local lsp_key_map = {}
-- nvim-lsp-installer: on_attach
function lsp_key_map.lsp_key_mapping(bufnr)

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end


    -- 对 "lsp-buf" 内置功能函数的按键映射.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
    -- buf_set_keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
    -- buf_set_keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
    -- buf_set_keymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
    -- buf_set_keymap("n", "<C-k>", ":lua vim.lsp.buf.signature_help()<CR>", opts)
    -- buf_set_keymap("n", "<space>wa", ":lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    -- buf_set_keymap("n", "<space>wr", ":lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    -- buf_set_keymap("n", "<space>wl", ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    -- buf_set_keymap("n", "<space>D", ":lua vim.lsp.buf.type_definition()<CR>", opts)
    -- buf_set_keymap("n", "<space>rn", ":lua vim.lsp.buf.rename()<CR>", opts)
    -- buf_set_keymap("n", "<space>ca", ":lua vim.lsp.buf.code_action()<CR>", opts)
    -- buf_set_keymap("n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
    -- buf_set_keymap("n", "<space>f", ":lua vim.lsp.buf.formatting()<CR>", opts)
    buf_set_keymap("n", "<space>e", ":lua vim.diagnostic.open_float()<CR>", opts)
    -- buf_set_keymap("n", "[d", ":lua vim.diagnostic.goto_prev()<CR>", opts)
    -- buf_set_keymap("n", "]d", ":lua vim.diagnostic.goto_next()<CR>", opts)
    -- buf_set_keymap("n", "<space>q", ":lua vim.diagnostic.setloclist()<CR>", opts)

    -- 对 tami5/lspsaga.nvim 的功能函数进行按键映射
    -- Bug: [LspSaga] get root dir failed
    -- buf_set_keymap("n", "gh", ":Lspsaga lsp_finder<CR>", opts)
    buf_set_keymap("n", "gr", ":Lspsaga rename<cr>", opts)
    buf_set_keymap("n", "gx", ":Lspsaga code_action<cr>", opts)
    buf_set_keymap("x", "gx", ":<c-u>Lspsaga range_code_action<cr>", opts)
    buf_set_keymap("n", "K",  ":Lspsaga hover_doc<cr>", opts)
    buf_set_keymap("n", "go", ":Lspsaga show_line_diagnostics<cr>", opts)
    buf_set_keymap("n", "gj", ":Lspsaga diagnostic_jump_next<cr>", opts)
    buf_set_keymap("n", "gk", ":Lspsaga diagnostic_jump_prev<cr>", opts)
    buf_set_keymap("n", "<C-u>", ":lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", opts)
    buf_set_keymap("n", "<C-d>", ":lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", opts)
    buf_set_keymap("n", "gs", ":Lspsaga signature_help<cr>", opts)
    buf_set_keymap("n", "gd", ":Lspsaga preview_definition<cr>", opts)
    -- buf_set_keymap("n", "<Esc>", ":close!<cr>", opts)
end
return lsp_key_map
