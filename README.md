# jumpsigns.nvim

> Show jump locations in the signcolumn

This plugin shows jump locations of different motions in the sign column, to
quickly glance which motion to use to get somewhere quickly.

Currently supported motions:
- [`H`](https://neovim.io/doc/user/motion.html#H) /
  [`M`](https://neovim.io/doc/user/motion.html#M) /
  [`L`](https://neovim.io/doc/user/motion.html#L)
- More to come!

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

## To Do's

- Implement more jump motions:
  - [`{`](https://neovim.io/doc/user/motion.html#{) / [`}`](https://neovim.io/doc/user/motion.html#})?
  - [`[[`](https://neovim.io/doc/user/motion.html#[[) / [`]]`](https://neovim.io/doc/user/motion.html#]])?
  - ...
- Support disabling certain jump motions
- Probably include tests
