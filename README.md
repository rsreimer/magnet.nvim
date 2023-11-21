# magnet.nvim

_-- Want to find a needle in a haystack? Use a magnet.nvim!_

Narrow your find files and live grep by first selecting a directory to search in.

In addition, live grep supports globs by appending a prompt with glob patterns separated by two spaces.

E.g. to find require calls in lua files only, you can type:
`require<space><space>*.lua`

## Installation

Install the plugin as a Telescope extension.

```lua
-- lazy.nvim
{
  "telescope.nvim",
  dependencies = {
    {
      "rsreimer/magnet.nvim",
      config = function()
        require("telescope").load_extension("magnet")
      end,
    },
  },
  keys = {
      -- find files
      { "<leader>sf", "<cmd>lua require('telescope').extensions.magnet.find_file()<cr>", desc = "Find Files" },
      { "<leader>sF", "<cmd>lua require('telescope').extensions.magnet.find_file({ pick_dir = true })<cr>", desc = "Find Files in Directory" },

      -- live grep
      { "<leader>sg", "<cmd>lua require('telescope').extensions.magnet.find_text()<cr>", desc = "Grep" },
      { "<leader>sG", "<cmd>lua require('telescope').extensions.magnet.find_text({ pick_dir = true })<cr>", desc = "Grep in Directory" },
  }
}
```

## Credits

This plugin is inspired by:

[https://github.com/tjdevries/config_manager](https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/telescope/custom/multi_rg.lua)

https://github.com/princejoogie/dir-telescope.nvim
