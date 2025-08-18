vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(event)
		BindLspKeys()

		local client = vim.lsp.get_client_by_id(event.data.client_id)

		if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
			local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", {
				clear = false,
			})

			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,

				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-detach", {
					clear = true,
				}),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({
						group = "kickstart-lsp-highlight",
						buffer = event2.buf,
					})
				end,
			})
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "org",
	callback = function()
		vim.opt_local.textwidth = 80
		vim.opt_local.formatoptions = "jcroqlnt"
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.opt.conceallevel = 0
  end,
})

local orgmode_global_keymaps = vim.api.nvim_create_augroup("OrgmodeGlobalKeymaps", { clear = true })

-- Define keymaps that you want to be available in *any* file
-- Be very selective here! Most orgmode keymaps are context-dependent.
vim.api.nvim_create_autocmd("BufEnter", { -- Or "BufReadPost", "FileType", etc.
	group = orgmode_global_keymaps,
	pattern = "*", -- Apply to all file types
	callback = function()
		-- Example: Make <leader>oa (org-agenda) available everywhere
		vim.keymap.set("n", "<leader>oa", function()
			require("orgmode").action("agenda.prompt")
		end, { noremap = true, silent = true, desc = "Org Agenda" })

		-- Example: Make <leader>oc (org-capture) available everywhere
		vim.keymap.set("n", "<leader>oc", function()
			require("orgmode").action("capture.prompt")
		end, { noremap = true, silent = true, desc = "Org Capture" })

		-- Add other *specific* orgmode keybinds you want globally.
		-- Be careful not to override common Neovim or other plugin keybinds.
	end,
})
