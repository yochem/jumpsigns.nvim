local M = {}

local ns = vim.api.nvim_create_namespace("jumpsigns")

local function hml_signs()
  local last_line = vim.api.nvim_buf_line_count(0)
  if last_line <= 3 then
    return {}
  end

  local scrolloff = vim.wo.scrolloff

  -- No offset when first line is visible
  local viewport_top = vim.fn.line('w0')
  local H_offset = viewport_top == 1 and 0 or scrolloff
  local H_linenr = viewport_top + H_offset

  -- No offset when last line is visible
  local viewport_bottom = vim.fn.line('w$')
  local L_offset = viewport_bottom >= last_line and 0 or scrolloff
  local L_linenr = viewport_bottom - L_offset

  local M_linenr = math.floor((viewport_bottom - viewport_top) / 2 + viewport_top)

  return { H = H_linenr, M = M_linenr, L = L_linenr }
end

M.config = {
  signs = {
    H = { text = "H", hl_group = "" },
    M = { text = "M", hl_group = "" },
    L = { text = "L", hl_group = "" },
  },
  priority = 11,
  enabled = true,
}

local function create_autocmd()

end

local function cleanup()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  end
  vim.api.nvim_del_augroup_by_name("jumpsigns")
end

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})

  if M.config.enabled then
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorHold" }, {
      callback = function()
        vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

        local signs = hml_signs()
        for sym, linenr in pairs(signs) do
          vim.api.nvim_buf_set_extmark(vim.api.nvim_get_current_buf(), ns, linenr - 1, 0, {
            sign_text = M.config.signs[sym].text,
            sign_hl_group = M.config.signs[sym].hl_group,
            priority = M.config.priority,
          })
        end
      end,
      group = vim.api.nvim_create_augroup("jumpsigns", { clear = true }),
    })
  else
    cleanup()
  end
end

return M
