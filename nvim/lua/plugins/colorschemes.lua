return {
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local C = require("nordic.colors")

			require("nordic").setup({
				-- This callback can be used to override the colors used in the palette.
				on_palette = function(palette)
					return palette
				end,
				-- Enable bold keywords.
				bold_keywords = false,
				-- Enable italic comments.
				italic_comments = true,
				-- Enable general editor background transparency.
				transparent_bg = false,
				-- Enable brighter float border.
				bright_border = true,
				-- Reduce the overall amount of blue in the theme (diverges from base Nord).
				reduced_blue = true,
				-- Swap the dark background with the normal one.
				swap_backgrounds = false,
				-- Override the styling of any highlight group.
				override = {
					TelescopePromptBorder = {
						fg = C.white0,
						bg = C.bg,
					},
					TelescopeResultsBorder = {
						fg = C.white0,
						bg = C.bg,
					},
					TelescopePreviewBorder = {
						fg = C.white0,
						bg = C.bg,
					},
				},
				-- Cursorline options.  Also includes visual/selection.
				cursorline = {
					-- Bold font in cursorline.
					bold = false,
					-- Bold cursorline number.
					bold_number = true,
					-- Available styles: 'dark', 'light'.
					theme = "dark",
					-- Blending the cursorline bg with the buffer bg.
					blend = 0.85,
				},
				noice = {
					-- Available styles: `classic`, `flat`.
					style = "flat",
				},
				telescope = {
					-- Available styles: `classic`, `flat`.
					style = "flat",
				},
				leap = {
					-- Dims the backdrop when using leap.
					dim_backdrop = false,
				},
				ts_context = {
					-- Enables dark background for treesitter-context window
					dark_background = true,
				},
			})
			require("nordic").load({})
		end,
	},
}
