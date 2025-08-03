-- plugins.lua or equivalent
return {
  {
    'stevearc/vim-arduino',
    ft = { 'arduino' },
    config = function()
      -- Optional: set the arduino-cli path if it's not in your system's PATH
      -- vim.g.arduino_cli_path = '/path/to/your/arduino-cli'
    end,
  },
}
