# jumpsigns.nvim

> Show jump locations in the signcolumn

![Example image](https://private-user-images.githubusercontent.com/23235841/397435597-8335abdb-7692-484f-a696-dd6e03d066b6.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzQ2MjI4MDgsIm5iZiI6MTczNDYyMjUwOCwicGF0aCI6Ii8yMzIzNTg0MS8zOTc0MzU1OTctODMzNWFiZGItNzY5Mi00ODRmLWE2OTYtZGQ2ZTAzZDA2NmI2LnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDEyMTklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQxMjE5VDE1MzUwOFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTFiZTIzZjJlNDYxNDhiNDY3ZWYzZWY2MmM0OTNkMzYwZDE1NzEzMzA3YzllMjY3N2YzN2IwZDdiYTY1NzA0NzkmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.sIxJUSKh6Z-UY9hxLJ4QUcgEz8bcVcByD5jLSy4ub-E)

<sup>In the image, the jumpsigns are highlighted in orange. This is not the
normal highlight color.</sup>

This plugin shows jump locations of different motions in the sign column, to
quickly glance which motion to use to get somewhere quickly.

## Features

- Currently supported motions:
  - [`H`](https://neovim.io/doc/user/motion.html#H) /
    [`M`](https://neovim.io/doc/user/motion.html#M) /
    [`L`](https://neovim.io/doc/user/motion.html#L)
  - [`{`](https://neovim.io/doc/user/motion.html#{) /
    [`}`](https://neovim.io/doc/user/motion.html#})
  - More to come!
- Checkhealth support: `:checkhealth jumpsigns`
- Highlighting groups: `:hi @jumpsigns.sign`
- Toggle on keymap: `:nmap <leader>js <Plug>(JumpSignsToggle)`

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
  priority = 11,
  signs = {
    window_high = { text = "H" },
    window_middle = { text = "M" },
    window_low = { text = "L" },
    paragraph_prev = { text = "{" },
    paragraph_next = { text = "}" },
  },
}
```

All `signs` configurations also accept an `enabled` and `priority` argument to
control the individual jumpsign.

## Tips

### Highlights
To change colors/highlighting, use Nvims builtin highlight commands:

```lua
-- Change highlight of all signs
vim.api.nvim_set_hl(0, "@jumpsigns.sign", { fg = "Orange" })

-- or change only one (e.g. for `H`)
vim.api.nvim_set_hl(0, "@jumpsigns.sign.window_high", { fg = "Gray" })
```

### Toggle and lazy-load
To toggle, enable, or disable this plugin, `<Plug>(JumpSignsToggle)`,
`<Plug>(JumpSignsEnable)`, and `<Plug>(JumpSignsToggle)` are exposed. For
example, to lazy-load on a keymap:

```lua
require("jumpsigns").setup({ enabled = false })
vim.keymap.set("n", "<leader>js", "<Plug>(JumpSignsToggle)")
```

## Similar Projects

- [mawkler/hml.nvim](https://github.com/mawkler/hml.nvim): Inspired this
  plugin, always places signs in number column.
- [tris203/precognition.nvim](https://github.com/tris203/precognition.nvim):
  Also shows linewise jump targets in a virtual lines below the current line.
