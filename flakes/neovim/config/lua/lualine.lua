local options = {
   	options = {
		icons_enabled = true,
		theme = "auto",
		globalstatus = true,
		component_separators = { left = "", right = " " },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
		ignore_focus = {},
		always_divide_middle = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
}

require("lualine").setup(options)
