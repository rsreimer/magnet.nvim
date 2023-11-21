local sorters = require("telescope.sorters")
local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")
local Options = require("magnet.options")

local M = {}

function M.picker(opts)
	local vimgrep_arguments = opts.vimgrep_arguments or conf.vimgrep_arguments
	local search_dirs = opts.search_dirs
	local glob_aliases = opts.glob_aliases or Options.default_glob_aliases
	opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()

	if search_dirs then
		for i, path in ipairs(search_dirs) do
			search_dirs[i] = vim.fn.expand(path)
		end
	end

	local live_grepper = finders.new_job(function(input)
		if not input or input == "" then
			return nil
		end

		local input_split = vim.split(input, "  ")

		local prompt = input_split[1]
		local glob = input_split[2]

		local glob_arguments = {}

		if glob then
			local glob_patterns = vim.split(glob_aliases[glob] or glob, ",")

			for _, pattern in ipairs(glob_patterns) do
				if pattern ~= "" and pattern ~= "*" then
					glob_arguments[#glob_arguments + 1] = "--glob=" .. pattern
				end
			end
		end

		return vim.tbl_flatten({ vimgrep_arguments, glob_arguments, "--", prompt, search_dirs })
	end, opts.entry_maker or make_entry.gen_from_vimgrep(opts), opts.max_results, opts.cwd)

	pickers
		.new(opts, {
			prompt_title = "Live Grep",
			finder = live_grepper,
			previewer = conf.grep_previewer(opts),
			sorter = sorters.highlighter_only(opts),
		})
		:find()
end

return M
