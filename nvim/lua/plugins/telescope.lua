return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>sf", builtin.find_files, {})
			vim.keymap.set("n", "<leader>sg", builtin.git_files, {})
			vim.keymap.set("n", "<leader>sw", builtin.grep_string)
			vim.keymap.set("n", "<leader>sl", builtin.live_grep)
			-- vim.keymap.set("n", "<leader>ps", function()
			-- 	builtin.grep_string({ search = vim.fn.input("Grep > ") })
			-- end)
			vim.keymap.set("n", "<leader>?", builtin.oldfiles)
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end)

			vim.keymap.set("n", "<leader>gr", builtin.lsp_references, {})
			vim.keymap.set("n", "<leader>gd", builtin.lsp_definitions, {})
			vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, {})
			vim.keymap.set("n", "<leader>ws", builtin.lsp_workspace_symbols, {})

			require("telescope").setup({
				defaults = {
					-- initial_mode = 'normal'
				},
			})
		end,
	},
}
