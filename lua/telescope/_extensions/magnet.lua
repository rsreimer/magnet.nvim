local Magnet = require("magnet")

return require("telescope").register_extension({
	exports = {
		find_text = Magnet.find_text,
		find_file = Magnet.find_file,
		find_directory = Magnet.find_directory,
	},
})
