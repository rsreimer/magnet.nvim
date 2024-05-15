local builtin = require("telescope.builtin")
local find_directory = require("magnet.finders.directory")
local Grep = require("magnet.finders.grep")

local M = {}

function M.find_directory(opts)
	opts = opts or {}

	find_directory(opts, function(dirs)
		vim.cmd("e " .. dirs)
	end)
end

function M.find_text(opts)
	opts = opts or {}

	if opts.pick_dir then
		find_directory(opts, function(dirs)
			opts.search_dirs = dirs
			Grep.picker(opts)
		end)
	else
		Grep.picker(opts)
	end
end

function M.find_file(opts)
	opts = opts or {}

	if opts.pick_dir then
		find_directory(opts, function(dirs)
			opts.search_dirs = dirs
			builtin.find_files(opts)
		end)
	else
		builtin.find_files(opts)
	end
end

return M
