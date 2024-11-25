return {
  -- Can be used to disable plugin:
  -- :lua require("jumpsigns").setup({ enabled = false })
  enabled = true,

  -- Default priority of all jumpsigns, set higher to overwrite other signs
  priority = 11,

  -- Text shown for the sign
  signs = {
    window_high = { text = "H", enabled = true, priority = nil },
    window_middle = { text = "M", enabled = true, priority = nil },
    window_low = { text = "L", enabled = true, priority = nil },
    paragraph_prev = { text = "{", enabled = true, priority = nil },
    paragraph_next = { text = "}", enabled = true, priority = nil },
  },
}
