local options = {
	options = {
		always_show_bufferline = false,
		separator_style = "slope",
		color_icons = true,
		max_prefix_length = 8,
		modified_icon = "",
		show_close_icon = false,
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(_, _, diag)
			local ret = (diag.error and ICONS.diagnostics.Error .. diag.error .. " " or "")
				.. (diag.warning and ICONS.diagnostics.Warn .. diag.warning or "")
			return vim.trim(ret)
		end,

		offsets = {
			{
				filetype = "neo-tree",
				text = "Neo-tree",
				highlight = "Directory",
				text_align = "left",
			},
		},

		---@param opts bufferline.IconFetcherOpts
		get_element_icon = function(opts)
			return ICONS.ft[opts.filetype]
		end,
	},
}

require("bufferline").setup(options)
