vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

BindLspKeys = function()
	local map = function(keys, func, desc, mode)
		mode = mode or "n"
		vim.keymap.set(mode, keys, func)
	end

	map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
	map("gd", "<cmd>Telescope lsp_definitions<CR>", "[g]oto defenitions")
	map("gi", "<cmd>Telescope lsp_implementations<CR>", "[g]oto [i]implementations")
	map("gt", "<cmd>Telescope lsp_type_definitions<CR>", "[g]oto [t]ype defenition")
	map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	map("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ctions")
	map("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
	map("<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "[D]iagnostics")
	map("<leader>d", vim.diagnostic.open_float, "line [d]isgnostics")
	map("[d", vim.diagnostic.goto_prev, "prev diagnostic")
	map("]d", vim.diagnostic.goto_prev, "next diagnostic")
end
