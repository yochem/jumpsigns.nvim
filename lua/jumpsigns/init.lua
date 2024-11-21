local M = {}

M.config = require("jumpsigns.config")

local ns = vim.api.nvim_create_namespace("jumpsigns")

local function hml_signs()
  local viewport_top = vim.fn.line('w0')
  local viewport_bottom = vim.fn.line('w$')
  if viewport_bottom - viewport_top < 2 then
    return {}
  end
  local last_line = vim.api.nvim_buf_line_count(0)

  local scrolloff = vim.wo.scrolloff

  local H_linenr
  if viewport_top == 1 then
    H_linenr = 1
  elseif viewport_top + scrolloff < viewport_bottom then
    H_linenr = viewport_top + scrolloff
  end

  local L_linenr
  if viewport_bottom >= last_line then
    L_linenr = last_line
  elseif viewport_bottom - scrolloff >= viewport_top then
    L_linenr = viewport_bottom - scrolloff
  end

  local M_linenr
  local middle = math.floor((viewport_bottom - viewport_top) / 2 + viewport_top)
  if middle < viewport_bottom - scrolloff then
    M_linenr = middle
  end

  return { H = H_linenr, M = M_linenr, L = L_linenr }
end

local function create_autocmd()
  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorHold" }, {
    callback = function()
      local signs = hml_signs()
      vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
      for sym, linenr in pairs(signs) do
        vim.api.nvim_buf_set_extmark(0, ns, linenr - 1, 0, {
          sign_text = M.config.signs[sym].text,
          sign_hl_group = "@jumpsigns.sign." .. sym,
          priority = M.config.priority,
        })
      end
    end,
    desc = "update jumpsigns signs",
    group = vim.api.nvim_create_augroup("jumpsigns", { clear = true }),
  })
end

local function cleanup()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  end
  vim.api.nvim_del_augroup_by_name("jumpsigns")
end

local function highlights()
  vim.api.nvim_set_hl(0, "@jumpsigns.sign", { link = "SignColumn", default = true })
  for sign, _ in pairs(M.config.signs) do
    -- e.g. @jumpsigns.sign.L -> @jumpsigns.sign
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

  -- set up highlight settings
  highlights()
  create_autocmd()
end

return M
