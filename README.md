# jumpsigns.nvim

> Show jump locations in the signcolumn

This plugin shows jump locations of different motions in the sign column, to
quickly glance which motion to use to get somewhere quickly.

## Features

- Currently supported motions:
  - [`H`](https://neovim.io/doc/user/motion.html#H) /
    [`M`](https://neovim.io/doc/user/motion.html#M) /
    [`L`](https://neovim.io/doc/user/motion.html#L)
  - More to come!
- Checkhealth support: `:checkhealth jumpsigns`
- Highlighting groups: `:hi @jumpsigns.sign`

This plugin is inspired by
[mawkler/hml.nvim](https://github.com/mawkler/hml.nvim).

## Installation

Lazy:
```lua
{
  "yochem/jumpsigns.nvim",
  opts = {}
}
```

For others, use the url from this repo and don't forget to call the setup
function somewhere in your config:

```lua
require("jumpsigns").setup()
```

## Configuration

Full configuration with comments in [config.lua](./lua/jumpsigns/config.lua).
This is the default:

```lua
{
  enabled = true,
  hl_all = nil,
  priority = 11,
  signs = {
    H = { text = "H" },
    M = { text = "M" },
    L = { text = "L" },
  },
}
```

The highlighting is handled via Nvims builtin highlight commands. For example:

```lua
-- this sets all signs to the color orange
vim.api.nvim_set_hl(0, "@jumpsigns.sign", { fg = "Orange" })

-- or change only one
vim.api.nvim_set_hl(0, "@jumpsigns.sign.H", { fg = "Gray" })
```

Or in vimscript:

```vim
hi @jumpsigns.sign.M guifg=Orange
```


## To Do's

- Implement more jump motions:
  - [`{`](https://neovim.io/doc/user/motion.html#{) / [`}`](https://neovim.io/doc/user/motion.html#})?
  - [`[[`](https://neovim.io/doc/user/motion.html#[[) / [`]]`](https://neovim.io/doc/user/motion.html#]])?
  - ...
- Support disabling certain jump motions
- Probably include tests

## Similar Projects

- [mawkler/hml.nvim](https://github.com/mawkler/hml.nvim): Inspired this
  plugin, always places signs in number column.
- [tris203/precognition.nvim](https://github.com/tris203/precognition.nvim):
  Also shows linewise jump targets in a virtual lines below the current line.
