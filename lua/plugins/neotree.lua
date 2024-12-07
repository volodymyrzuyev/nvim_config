return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		config = function()
			require("neo-tree").setup({
				filesystem = {
					filtered_items = {
						visible = true, -- when true, they will just be displayed differently than normal items
					},
				},
			})
			vim.keymap.set("n", "<leader>E", "<cmd>Neotree last<CR>")
			vim.keymap.set("n", "<leader>X", "<cmd>Neotree close<CR>")
		end,
	},
}
