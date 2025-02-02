vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local jqx = vim.api.nvim_create_augroup("Jqx", {})
vim.api.nvim_clear_autocmds({ group = jqx })
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = { "*.json", "*.yaml" },
	desc = "preview json and yaml files on open",
	group = jqx,
	callback = function()
		vim.cmd.JqxList()
	end,
})
