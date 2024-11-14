return {
	{
		"Yazeed1s/minimal.nvim",
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("minimal-base16")
			vim.cmd.hi("Comment gui=none")
		end,
	},
}
