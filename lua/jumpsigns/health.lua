local M = {}

local function configuration()
  local config = require("jumpsigns").config
  local default = require("jumpsigns.config")

  vim.health.start("Enabled")
  if config.enabled then
    vim.health.ok("Plugin enabled")
  else
    vim.health.warn("Plugin disabled")
  end

  vim.health.start("Configuration")
  if vim.deep_equal(config, default) then
    vim.health.ok("using default configuration")
  else
    vim.health.info("Custom configuration:\n" .. vim.inspect(config))
  end
end

M.check = function()
  configuration()
end

return M
