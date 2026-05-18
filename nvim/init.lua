vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2 -- Number of spaces that a <Tab> character represents
vim.opt.softtabstop = 2 -- Number of spaces that a <Tab> counts for during editing operations
vim.opt.shiftwidth = 2 -- Number of spaces to use for each step of automatic indentation
vim.opt.expandtab = true -- Converts tabs into spaces when typing
vim.opt.smartindent = true -- Automatically inserts an extra level of indentation in some cases
vim.opt.cursorline = true -- Show which line your cursor is on
-- vim.opt
vim.opt.signcolumn = "yes:2"

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true
vim.o.winborder = "rounded"
-- vim.o.pumborder = "rounded" -- rounded border on the completion popup
vim.o.pumborder = "rounded"
vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuBorder", { bg = "NONE", fg = "#98FB98" })

vim.keymap.set("n", "q", "<Nop>", { noremap = true, silent = true }) -- prevent accidentally starting macro recording
vim.keymap.set("x", "Y", '"+y', { noremap = true, silent = true, desc = "Copy visual selection to system clipboard" })
vim.keymap.set("n", "<leader>b", "<C-^>", { noremap = true, silent = true, desc = "Switch to alternate buffer" })

-- LSP autocompletion
vim.opt.completeopt = "menu,menuone,noselect,popup" -- Ensures the menu appears even for a single match and uses the native popup window.
vim.o.autocomplete = true -- Enables the overall completion feature.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_completion", { clear = true }),
	callback = function(args)
		local client_id = args.data.client_id
		if not client_id then
			return
		end

		local client = vim.lsp.get_client_by_id(client_id)
		if client and client:supports_method("textDocument/completion") then
			-- Enable native LSP completion for this client + buffer
			vim.lsp.completion.enable(true, client_id, args.buf, {
				autotrigger = true, -- auto-show menu as you type (recommended)
				-- You can also set { autotrigger = false } and trigger manually with <C-x><C-o>
			})
		end
	end,
})

-- Highlight when yanking (copying) text (See `:help vim.hl.on_yank()`)
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Clear highlights on search when pressing <Esc> in normal mode (See `:help hlsearch`)
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>quitall<cr>", { desc = "Exit vim" })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.pack.add({
	-- "https://github.com/alexvzyl/nordic.nvim", -- theme
	"https://github.com/christoomey/vim-tmux-navigator",
	"https://github.com/neovim/nvim-lspconfig", -- pre-written default LSP configs
	"https://github.com/mason-org/mason.nvim", -- manage LSP servers, DAP, linters, formatters
	"https://github.com/stevearc/conform.nvim", -- formatter plugin
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/nvim-mini/mini.nvim", -- collection of plugins
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/folke/which-key.nvim",
})

vim.lsp.enable({ "lua_ls" })
vim.lsp.enable({ "basedpyright" })
vim.lsp.enable({ "ruff" })
vim.lsp.enable({ "stylua" })
vim.lsp.enable({ "gopls" })

-- require("nordic").load()
require("mason").setup()
require("mini.icons").setup()
require("mini.pairs").setup() -- autopairs for brackets, quotes
require("mini.diff").setup({ -- git diff, hunks
	view = { style = "sign" },
})
require("mini.jump").setup()
local hipatterns = require("mini.hipatterns")
hipatterns.setup({
	highlighters = {
		-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

		-- Highlight hex color strings (`#rrggbb`) using that color
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})
vim.keymap.set("n", "<leader>gd", function()
	require("mini.diff").toggle_overlay()
end, { desc = "Toggle diff overlay" })

require("conform").setup({
	formatters_by_ft = {
		python = { "ruff_format" },
		lua = { "stylua" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		json = { "prettier" },
		markdown = { "prettier" },
		rust = { "rustfmt" },
		go = { "gofmt" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true, -- fall back to LSP formatting if no conform formatter
	},
})
require("lualine").setup({
	-- options = { theme = "tomorrow_night" },
	sections = {
		lualine_x = { -- show lsp
			{
				function()
					local clients = vim.lsp.get_clients({ bufnr = 0 })
					if #clients == 0 then
						return ""
					end
					local names = {}
					for _, client in ipairs(clients) do
						table.insert(names, client.name)
					end
					return " " .. table.concat(names, ", ")
				end,
			},
			"encoding",
			"fileformat",
			"filetype",
		},
	},
})
local fzf = require("fzf-lua")
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fr", fzf.oldfiles, { desc = "Recent files" })
vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "Help tags" })

require("vim._core.ui2").enable({})
