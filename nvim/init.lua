require("vim._core.ui2").enable({})

----------------------------------------------------------------------------------------------------
-- OPTIONS
----------------------------------------------------------------------------------------------------
vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.scrolloff = 10 -- keep 10 lines above/below cursor
vim.opt.sidescrolloff = 10

vim.opt.tabstop = 2 -- Number of spaces that a <Tab> character represents
vim.opt.softtabstop = 2 -- Number of spaces that a <Tab> counts for during editing operations
vim.opt.shiftwidth = 2 -- Number of spaces to use for each step of automatic indentation
vim.opt.expandtab = true -- Converts tabs into spaces when typing
vim.opt.smartindent = true -- Automatically inserts an extra level of indentation in some cases

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hlsearch = true -- highlight search results
vim.opt.incsearch = true -- show matches while typing

vim.opt.signcolumn = "yes:2" -- left side gutter width
-- vim.opt.colorcolumn = "100" -- show column at 100 characters
vim.opt.showmatch = true -- highlight matching brackets
vim.opt.cmdheight = 1 -- command line height
vim.opt.pumblend = 10 -- popup menu transparency
vim.opt.winblend = 10 -- floating window transparency
vim.o.pumborder = "rounded" -- rounded border on the completion popup
vim.o.winborder = "rounded" -- rounded border on floating window
vim.opt.splitbelow = true

vim.opt.autoread = true -- auto-reload changes if outside of neovim
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false -- don't create swap files
vim.opt.undofile = true -- persistent undo
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.iskeyword:append("-") -- treat hyphen as one word

-- vim.opt.laststatus = 3 -- if want to continuous status bar when split screen

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" })
-- vim.api.nvim_set_hl(0, "PmenuBorder", { bg = "NONE", fg = "#98FB98" }) -- customize pop up menu
-- vim.o.autocomplete = true -- Enables the overall completion feature. (using mini.completion instead)

----------------------------------------------------------------------------------------------------
-- KEYMAPS
----------------------------------------------------------------------------------------------------
-- vim.keymap.set("n", "q", "<Nop>", { noremap = true, silent = true }) -- prevent accidentally starting macro recording
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Clear highlights on search when pressing <Esc> in normal mode (See `:help hlsearch`)

vim.keymap.set("n", "<leader>w", "<cmd>write<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<CR>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>Q", "<cmd>quitall<CR>", { desc = "Exit vim" })
-- vim.keymap.set("n", "<leader>e", ":Ex<CR>", { desc = "Open Netrw file explorer" })
vim.keymap.set("x", "Y", '"+y', { noremap = true, silent = true, desc = "Copy visual selection to system clipboard" })
vim.keymap.set("n", "<leader>bs", "<C-^>", { noremap = true, silent = true, desc = "Switch to alternate buffer" })
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })
vim.keymap.set("n", "<leader>yy", '"+y', { desc = "Yank to system clipboard" })
-- yank file path to system clipboard
vim.keymap.set("n", "<leader>yp", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "Copy full file path" })
-- create new file
vim.keymap.set("n", "<leader>nf", function()
	local dir = vim.fn.expand("%:p:h")
	local filename = vim.fn.input("New file: ", dir .. "/")
	if filename ~= "" then
		vim.cmd("edit " .. vim.fn.fnameescape(filename))
	end
end, { desc = "New file in same directory" })
-- undotree
vim.keymap.set("n", "<leader>u", function()
	vim.cmd.packadd("nvim.undotree")
	require("undotree").open()
end, { desc = "Undotree" })
vim.keymap.set("n", "<leader>re", ":restart<CR>", { desc = "Restart neovim" })
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>s1", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>")
vim.keymap.set("n", "<leader>s2", "<cmd>silent !tmux neww tmux-sessionizer -s 1<CR>")
vim.keymap.set("n", "<leader>s3", "<cmd>silent !tmux neww tmux-sessionizer -s 2<CR>")
vim.keymap.set("n", "<leader>s4", "<cmd>silent !tmux neww tmux-sessionizer -s 3<CR>")

----------------------------------------------------------------------------------------------------
-- AUTOCOMMANDS
----------------------------------------------------------------------------------------------------
-- Highlight when yanking text (See `:help vim.hl.on_yank()`)
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Start treesitter (syntax highlighting, etc.)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function(args)
		local buf = args.buf
		local ft = vim.bo[buf].filetype

		local lang = vim.treesitter.language.get_lang(ft)
		if not lang then
			return
		end

		local ok_add = pcall(vim.treesitter.language.add, lang)
		if not ok_add then
			return
		end

		pcall(vim.treesitter.start, buf, lang)
	end,
})

----------------------------------------------------------------------------------------------------
-- PLUGINS
----------------------------------------------------------------------------------------------------
vim.pack.add({
	{
		src = "https://github.com/rose-pine/neovim",
		name = "rose-pine",
	},
	"https://github.com/alexvzyl/nordic.nvim",

	"https://github.com/nvim-mini/mini.nvim", -- collection of plugins

	"https://github.com/christoomey/vim-tmux-navigator", -- navigate between vim and tmux splits
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/sphamba/smear-cursor.nvim",
	"https://github.com/nvim-zh/colorful-winsep.nvim",
	"https://github.com/j-hui/fidget.nvim", -- notification ui for lsp progress msgs

	"https://github.com/neovim/nvim-lspconfig", -- pre-written default LSP configs
	"https://github.com/mason-org/mason.nvim", -- manage LSP servers, DAP, linters, formatters
	"https://github.com/stevearc/conform.nvim", -- formatter plugin
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main", build = ":TSUpdate" },
	"https://github.com/nvim-treesitter/nvim-treesitter-context", -- show current context (e.g. current function)
	"https://github.com/rafamadriz/friendly-snippets", -- snippet collection, loaded in runtimepath

	"https://github.com/folke/which-key.nvim",
	"https://github.com/folke/zen-mode.nvim",

	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/kdheepak/lazygit.nvim", -- access lazygit ui in neovim
	"https://github.com/sindrets/diffview.nvim",
	"https://github.com/nvim-lua/plenary.nvim", -- harpoon dependency
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" }, -- quick switching among few commonly used files
})

----------------------------------------------------------------------------------------------------
-- THEME
----------------------------------------------------------------------------------------------------
-- require("nordic").load()
require("rose-pine").setup({
	-- palette = {
	-- 	main = {
	-- 		base = "#000000",
	-- 	},
	-- },
	highlight_groups = {
		Visual = { fg = "base", bg = "text", inherit = false }, -- visual mode highlight is more visible
	},
})
vim.cmd("colorscheme rose-pine")

----------------------------------------------------------------------------------------------------
-- PLUGIN KEYMAPS
----------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>ff", require("fzf-lua").files, { desc = "FZF Files" })
vim.keymap.set("n", "<leader>fg", require("fzf-lua").live_grep, { desc = "FZF Live grep" })
vim.keymap.set("n", "<leader>fb", require("fzf-lua").buffers, { desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>fr", require("fzf-lua").oldfiles, { desc = "FZF Recent files" })
vim.keymap.set("n", "<leader>fh", require("fzf-lua").help_tags, { desc = "FZF Help tags" })
vim.keymap.set("n", "<leader>fk", require("fzf-lua").keymaps, { desc = "FZF Keymappings" })
vim.keymap.set("n", "ds", require("fzf-lua").lsp_document_symbols, { desc = "FZF LSP symbols in document" })
vim.keymap.set("n", "grr", require("fzf-lua").lsp_references, { desc = "FZF LSP references" })
vim.keymap.set("n", "gd", require("fzf-lua").lsp_definitions, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>fz", require("fzf-lua").zoxide, { desc = "FZF zoxide" })
vim.keymap.set("n", "<leader>fu", require("fzf-lua").undotree, { desc = "FZF undotree" })
vim.keymap.set("n", "<leader>fR", require("fzf-lua").resume, { desc = "FZF resume" })
vim.keymap.set("n", "<leader>fB", require("fzf-lua").resume, { desc = "FZF builtin" })
vim.keymap.set(
	"n",
	"<leader>fd",
	require("fzf-lua").diagnostics_document,
	{ desc = " FZF Diagnostic in current document" }
)
vim.keymap.set(
	"n",
	"<leader>fD",
	require("fzf-lua").diagnostics_workspace,
	{ desc = " FZF Diagnostic in current workspace" }
)
vim.keymap.set("n", "<leader>z", function()
	require("zen-mode").toggle()
end, { desc = "Zen mode" })
vim.keymap.set("n", "<leader>gd", function()
	require("mini.diff").toggle_overlay()
end, { desc = "Git diff" })
vim.keymap.set("n", "<leader>gD", function()
	local lib = require("diffview.lib")
	local view = lib.get_current_view()
	if view then
		vim.cmd("DiffviewClose")
	else
		vim.cmd("DiffviewOpen")
	end
end, { desc = "Git diffview (project scope)" })

vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<CR>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open lazygit UI" })
----------------------------------------------------------------------------------------------------
-- CONFIGS
----------------------------------------------------------------------------------------------------
vim.lsp.enable({
	"lua_ls",
	"stylua",
	"basedpyright",
	"ruff",
	"ts_ls",
	"gopls",
	"rust_analyzer",
	"rustfmt",
	"postgres_lsp",
	"tailwindcss",
	"astro",
	"jdtls",
})

require("nvim-treesitter").install({
	"lua",
	"python",
	"javascript",
	"typescript",
	"tsx",
	"rust",
	"go",
	"html",
	"css",
	"zsh",
	"markdown",
	"yaml",
	"java",
})

-- enable folds
-- vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.wo[0][0].foldmethod = "expr"
-- enable indents
-- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

require("conform").setup({
	formatters_by_ft = {
		python = { "ruff_format" },
		lua = { "stylua" },
		html = { "prettier" },
		css = { "prettier" },
		javascript = { "prettier" },
		javascriptreact = { "prettier" }, -- JSX
		typescript = { "prettier" },
		typescriptreact = { "prettier" }, -- TSX
		json = { "prettier" },
		markdown = { "prettier" },
		rust = { "rustfmt" },
		go = { "gofmt" },
		astro = { "prettier" },
		yaml = { "prettier" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true, -- fall back to LSP formatting if no conform formatter
	},
})

require("lualine").setup({
	options = { icons_enabled = true },
	sections = {
		lualine_c = {
			{
				"filetype",
				icon_only = true,
				separator = "",
				padding = { left = 0, right = 1 },
			},
			{
				"filename",
				path = 4,
			},
		},
		lualine_x = { -- show lsp
			{
				function()
					local clients = vim.lsp.get_clients({ bufnr = 0 })
					if #clients == 0 then
						return ""
					end
					local names = {}
					for _, client in ipairs(clients) do
						if client.name ~= "mini.snippets" then
							table.insert(names, client.name)
						end
					end
					return " " .. table.concat(names, ", ")
				end,
			},
			{
				"encoding", -- don't show encoding (e.g. utf-8)
				-- cond = function()
				-- 	local fenc = vim.bo.fenc ~= "" and vim.bo.fenc or vim.go.enc
				-- 	return fenc ~= "utf-8"
				-- end,
			},
			"fileformat",
			"filetype",
		},
	},
})

require("mason").setup()
require("colorful-winsep").setup()
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons() -- used for lualine icons
require("mini.completion").setup() -- autocompletion plugin (automatic triggering, lsp integration, completion popup and window, snippets). improves over native completion api
require("mini.files").setup() -- file explorer
require("mini.cmdline").setup() -- command completion

-- snippet engine
-- require("mini.snippets").setup({
-- 	mappings = {
-- 		expand = "",
-- 	},
-- 	snippets = {
-- 		require("mini.snippets").gen_loader.from_lang(),
-- 	},
-- })
-- MiniSnippets.start_lsp_server({ match = false })

require("mini.pairs").setup() -- autopairs for brackets, quotes etc.

-- diff overlay, hunks
require("mini.diff").setup({
	view = { style = "sign" },
})

require("mini.jump").setup()

require("mini.hipatterns").setup({
	highlighters = {
		-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

		-- Highlight hex color strings (`#rrggbb`) using that color
		hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
	},
})
-- Set colour of TODO
vim.api.nvim_set_hl(0, "MiniHipatternsTodo", {
	fg = "#ffffff",
	bg = "#ff8800",
	bold = true,
})

local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "<leader>ha", function()
	harpoon:list():add()
	vim.notify("Added current buffer to harpoon list")
end, { desc = "Add to harpoon list" })
vim.keymap.set("n", "<leader>hl", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "View harpoon list" })
vim.keymap.set("n", "<leader>h1", function()
	harpoon:list():select(1)
end, { desc = "Switch to harpoon (1)" })
vim.keymap.set("n", "<leader>h2", function()
	harpoon:list():select(2)
end, { desc = "Switch to harpoon (2)" })
vim.keymap.set("n", "<leader>h3", function()
	harpoon:list():select(3)
end, { desc = "Switch to harpoon (3)" })
vim.keymap.set("n", "<leader>h4", function()
	harpoon:list():select(4)
end, { desc = "Switch to harpoon (4)" })
-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>hp", function()
	harpoon:list():prev()
end, { desc = "Switch to previous harpoon buffer" })
vim.keymap.set("n", "<leader>hn", function()
	harpoon:list():next()
end, { desc = "Switch to previous harpoon buffer" })

require("treesitter-context").setup()

require("fidget").setup({
	notification = {
		override_vim_notify = true,
	},
})

require("smear_cursor").setup()
----------------------------------------------------------------------------------------------------
-- OTHER
----------------------------------------------------------------------------------------------------
local diagnostic_signs = {
	Error = " ",
	Warn = " ",
	Hint = "",
	Info = "",
}

-- Diagnostic display state: false = errors only, true = all
local show_all_diagnostics = false

-- Start vim with errors diagnostics only
vim.diagnostic.config({
	severity_sort = true,
	virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
	signs = { severity = { min = vim.diagnostic.severity.ERROR } },
	underline = { severity = { min = vim.diagnostic.severity.ERROR } },
	float = { severity = { min = vim.diagnostic.severity.ERROR } },
})

-- Toggle with <leader>dt
vim.keymap.set("n", "<leader>dt", function()
	show_all_diagnostics = not show_all_diagnostics

	if show_all_diagnostics then
		vim.diagnostic.config({
			virtual_text = { prefix = "●", spacing = 4 },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
					[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
					[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
					[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
				},
			},
			underline = true,
			float = {
				border = "rounded",
				source = true,
				header = "",
				prefix = "",
				focusable = false,
				style = "minimal",
			},
		})
		vim.notify("Diagnostics: all", vim.log.levels.INFO)
	else
		local errors_only = { severity = { min = vim.diagnostic.severity.ERROR } }
		vim.diagnostic.config({
			virtual_text = errors_only,
			signs = errors_only,
			underline = errors_only,
			float = errors_only,
		})
		vim.notify("Diagnostics: errors only", vim.log.levels.INFO)
	end
end, { desc = "Toggle diagnostics (errors only / all)" })
