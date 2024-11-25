local M = {}

M.config = require("jumpsigns.config")
local signlines = require("jumpsigns.signlines")

local function update_signs(ns, signs)
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
  for sym, linenr in pairs(signs) do
    local sign_config = M.config.signs[sym]
    if sign_config and sign_config.enabled then
      vim.api.nvim_buf_set_extmark(0, ns, linenr - 1, 0, {
        sign_text = sign_config.text,
        sign_hl_group = "@jumpsigns.sign." .. sym,
        priority = sign_config.priority or M.config.priority,
      })
    end
  end
end

local function setup_autocmds()
  local augroup = vim.api.nvim_create_augroup("jumpsigns", { clear = true })

  vim.api.nvim_create_autocmd({ "CursorHold" }, {
    callback = function()
      update_signs(
        vim.api.nvim_create_namespace("jumpsigns/cursor"),
        signlines.paragraph_signs()
      )
    end,
    desc = "update cursor-based signs",
    group = augroup,
  })

  vim.api.nvim_create_autocmd({ "BufEnter", "WinScrolled", "WinResized" }, {
    callback = function()
      update_signs(
        vim.api.nvim_create_namespace("jumpsigns/window"),
        signlines.hml_signs()
      )
    end,
    desc = "update window-based signs",
    group = augroup,
  })
end

local function cleanup()
  vim.api.nvim_del_augroup_by_name("jumpsigns")
  for name, ns_id in pairs(vim.api.nvim_get_namespaces()) do
    if name:match("jumpsigns") then
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
      end
    end
  end
end

local function setup_highlights()
  vim.api.nvim_set_hl(0, "@jumpsigns.sign", { link = "SignColumn", default = true })
  for sign, _ in pairs(M.config.signs) do
    -- link e.g. @jumpsigns.sign.window_low to @jumpsigns.sign
    local hl_name = "@jumpsigns.sign." .. sign
    vim.api.nvim_set_hl(0, hl_name, { link = "@jumpsigns.sign", default = true })
  end
end

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})

  if not M.config.enabled then
    cleanup()
    return
  end

  setup_highlights()
  setup_autocmds()
end

return M
