return {
	{
		-- Autopair parentheses, quotes, etc
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		lazy = false,
		config = true,
	},
	{
		-- Markdown viewer
		"ellisonleao/glow.nvim",
		config = true,
		cmd = "Glow",
	},
	{
		-- Comments
		"numToStr/Comment.nvim",
		lazy = false,
		opts = {},
	},
	{
		-- Detect tabstop and shiftwidth automatically
		"tpope/vim-sleuth",
	},
	{
		-- Navigate tmux panes
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	{
		-- Highlight colours
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		-- Indentation guides
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		enabled = false,
		config = function()
			require("ibl").setup()
		end,
	},
	{
		-- Highlight uses of word under cursor
		"RRethy/vim-illuminate",
		opts = {},
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = true, -- show icons in the signs column
			sign_priority = 8, -- sign priority
			-- keywords recognized as todo comments
			keywords = {
				FIX = {
					icon = "? ", -- icon used for the sign, and in search results
					color = "error", -- can be a hex color, or a named color (see below)
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
					-- signs = false, -- configure signs for some keywords individually
				},
				TODO = { icon = "? ", color = "#b48ead" },
				HACK = { icon = "? ", color = "warning" },
				WARN = { icon = "? ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = "? ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = "? ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "? ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
			gui_style = {
				fg = "NONE", -- The gui style to use for the fg highlight group.
				bg = "BOLD", -- The gui style to use for the bg highlight group.
			},
			merge_keywords = true, -- when true, custom keywords will be merged with the defaults
			-- highlighting of the line containing the todo comment
			-- * before: highlights before the keyword (typically comment characters)
			-- * keyword: highlights of the keyword
			-- * after: highlights after the keyword (todo text)
			highlight = {
				multiline = true, -- enable multine todo comments
				multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
				multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
				before = "", -- "fg" or "bg" or empty
				keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
				after = "fg", -- "fg" or "bg" or empty
				pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
				comments_only = true, -- uses treesitter to match keywords in comments only
				max_line_len = 400, -- ignore lines longer than this
				exclude = {}, -- list of file types to exclude highlighting
			},
			-- list of named colors where we try to extract the guifg from the
			-- list of highlight groups or use the hex color if hl not found as a fallback
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#bf616a" },
				warning = { "DiagnosticWarn", "WarningMsg", "#ebcb8b" },
				info = { "DiagnosticInfo", "#b48ead" },
				hint = { "DiagnosticHint", "#a3be8c" },
				default = { "Identifier", "#5e81ac" },
				test = { "Identifier", "#8fbcbb" },
			},
			search = {
				command = "rg",
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				-- regex that will be used to match keywords.
				-- don't replace the (KEYWORDS) placeholder
				pattern = [[\b(KEYWORDS):]], -- ripgrep regex
				-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
			},
		},
		config = function()
			require("todo-comments").setup()
			vim.keymap.set("n", "]t", function()
				require("todo-comments").jump_next()
			end, { desc = "Next todo comment" })

			vim.keymap.set("n", "[t", function()
				require("todo-comments").jump_prev()
			end, { desc = "Previous todo comment" })

			-- You can also specify a list of valid jump keywords
			--[[ vim.keymap.set("n", "]t", function()
				require("todo-comments").jump_next({ keywords = { "ERROR", "WARNING" } })
			end, { desc = "Next error/warning todo comment" }) ]]
		end,
	},
}
