local action_set = require("telescope.actions.set")
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")

return function(opts, fn)
	vim.fn.jobstart({ "fd", "--type", "d", "--color", "never" }, {
		stdout_buffered = true,
		on_stdout = function(_, data)
			pickers
				.new(opts, {
					prompt_title = "Select Directory",
					finder = finders.new_table({ results = data, entry_maker = make_entry.gen_from_file(opts) }),
					previewer = conf.file_previewer(opts),
					sorter = conf.file_sorter(opts),
					attach_mappings = function(prompt_bufnr)
						action_set.select:replace(function()
							local current_picker = action_state.get_current_picker(prompt_bufnr)

							local dirs = {}
							local selections = current_picker:get_multi_selection()

							if vim.tbl_isempty(selections) then
								table.insert(dirs, action_state.get_selected_entry().value)
							else
								for _, selection in ipairs(selections) do
									table.insert(dirs, selection.value)
								end
							end

							actions.close(prompt_bufnr)

							fn(dirs)
						end)

						return true
					end,
				})
				:find()
		end,
	})
end
