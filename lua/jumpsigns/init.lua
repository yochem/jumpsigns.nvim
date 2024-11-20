local M = {}

M.config = require("jumpsigns.config")

local ns = vim.api.nvim_create_namespace("JumpSigns")

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
          sign_hl_group = "JumpSigns" .. sym,
          priority = M.config.priority,
        })
      end
    end,
    desc = "update jumpsigns signs",
    group = vim.api.nvim_create_augroup("JumpSigns", { clear = true }),
  })
end

local function cleanup()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  end
  vim.api.nvim_del_augroup_by_name("JumpSigns")
end


function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})

  if not M.config.enabled then
    cleanup()
    return
  end

  -- set up highlight settings
  for sign, sign_opts in pairs(M.config.signs) do
    local hl_name = "JumpSigns" .. sign
    local global = vim.api.nvim_get_hl(0, { name = hl_name }) or {}
    -- needed bc global is not {} but vim.empty_dict()
    global = vim.tbl_isempty(global) and nil or global
    vim.api.nvim_set_hl(
      0,
      hl_name,
      M.config.hl_all or sign_opts.hl_opts or global or { link = "SignColumn" }
    )
  end

  create_autocmd()
end

return M
