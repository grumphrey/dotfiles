return {
	"stevearc/oil.nvim",
	opts = {},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			-- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
			delete_to_trash = true,
		})
	end,
}
