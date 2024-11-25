# jumpsigns.nvim

> Show jump locations in the signcolumn

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
    H = { text = "H" },
    M = { text = "M" },
    L = { text = "L" },
  },
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

<details>
<summary>Vimscript:</summary>
```vim
hi @jumpsigns.sign.window_middle guifg=Orange
```
</details>

### Toggle and lazy-load
To toggle, enable, or disable this plugin, `<Plug>(JumpSignsToggle)`,
`<Plug>(JumpSignsEnable)`, and `<Plug>(JumpSignsToggle)` are exposed. For
example, to lazy-load on a keymap:

```lua
require("jumpsigns").setup({ enabled = false })
vim.keymap.set("n", "<leader>js", "<Plug>(JumpSignsToggle)")
```

<details>
<summary>Vimscript:</summary>
```vim
lua require("jumpsigns").setup({ enabled = false })
nnoremap <Leader>js <Plug>(JumpSignsToggle)
```
</details>

## Similar Projects

- [mawkler/hml.nvim](https://github.com/mawkler/hml.nvim): Inspired this
  plugin, always places signs in number column.
- [tris203/precognition.nvim](https://github.com/tris203/precognition.nvim):
  Also shows linewise jump targets in a virtual lines below the current line.
