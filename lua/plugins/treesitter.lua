return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master", -- This is fine for the plugin itself
	lazy = false,
	build = ":TSUpdate", -- This builds ALL parsers listed in ensure_installed
}
