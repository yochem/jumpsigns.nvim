return {
  -- Can be hotswitched. Will disable full plugin.
  -- To toggle:
  --    local js = require('jumpsigns')
  --    js.setup({ enabled = not js.enabled })
  enabled = true,

  -- Highlight group used for every signs. Same type as last argument of
  -- vim.api.nvim_set_hl
  hl_all = nil,

  -- Priority of this sign group, set higher to overwrite other signs
  priority = 11,

  -- Text shown for the sign
  signs = {
    H = { text = "H" },
    M = { text = "M" },
    L = { text = "L" },
  },
}
