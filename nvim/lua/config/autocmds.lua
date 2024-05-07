-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- -- close some filetypes with <q>
-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
-- 	pattern = {
-- 		"PlenaryTestPopup",
-- 		"help",
-- 		"lspinfo",
-- 		"man",
-- 		"notify",
-- 		"qf",
-- 		"spectre_panel",
-- 		"startuptime",
-- 		"tsplayground",
-- 		"neotest-output",
-- 		"checkhealth",
-- 		"neotest-summary",
-- 		"neotest-output-panel",
-- 	},
-- 	callback = function(event)
-- 		vim.bo[event.buf].buflisted = false
-- 		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
-- 	end,
-- })
