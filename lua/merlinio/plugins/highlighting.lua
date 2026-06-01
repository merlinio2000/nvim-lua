--- from kickstart.nvim
---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
	-- Check if a parser exists and load it
	if not vim.treesitter.language.add(language) then
		return
	end
	-- Enable syntax highlighting and other treesitter features
	vim.treesitter.start(buf, language)

	-- Enable treesitter based folds
	-- For more info on folds see `:help folds`
	-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
	-- vim.wo.foldmethod = 'expr'

	-- Check if treesitter indentation is available for this language, and if so enable it
	-- in case there is no indent query, the indentexpr will fallback to the vim's built in one
	local has_indent_query = vim.treesitter.query.get(language, "indents")
		~= nil

	-- Enable treesitter based indentation
	if has_indent_query then
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end
end

---@type LazySpec
return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local parsers = {
				"vimdoc",
				"vim",
				"regex",
				"lua",
				"luadoc",
				"bash",
				"c",
				"cpp",
				"diff",
				"rust",
				"python",
				"javascript",
				"typescript",
				"markdown",
				"markdown_inline",
			}
			require("nvim-treesitter").install(parsers)

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local buf, filetype = args.buf, args.match

					local language = vim.treesitter.language.get_lang(filetype)
					if not language then
						return
					end

					if language == "latex" then
						return
					end

					local max_filesize = 1024 * 1024 -- 1 MiB
					local ok, stats =
						pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						vim.print(
							"skipping treesitter because file is to large"
						)
						return
					end

					local installed_parsers =
						require("nvim-treesitter").get_installed("parsers")

					if vim.tbl_contains(installed_parsers, language) then
						-- Enable the parser if it is already installed
						treesitter_try_attach(buf, language)
					else
						-- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
						treesitter_try_attach(buf, language)
					end
				end,
			})
		end,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		submodules = false,
		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")

			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					commonlisp = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				highlight = {
					"RainbowDelimiterBlue",
					"RainbowDelimiterRed",
					"RainbowDelimiterCyan",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterYellow",
					"RainbowDelimiterOrange",
				},
				condition = function(bufnr)
					local max_filesize = 1024 * 1024 -- 1 MiB
					local ok, stats = pcall(
						vim.loop.fs_stat,
						vim.api.nvim_buf_get_name(bufnr)
					)
					if ok and stats and stats.size > max_filesize then
						return false
					else
						return true
					end
				end,
				blacklist = { "c", "cpp" },
			}
		end,
	},
}
