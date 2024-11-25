local M = {}

local function isempty(line)
  return string.match(line, [[^[\n\r]*$]]) ~= nil
end

local function get_line(nr)
  return vim.api.nvim_buf_get_lines(0, nr - 1, nr, true)[1]
end

function M.hml_signs()
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

  return { window_high = H_linenr, window_middle = M_linenr, window_low = L_linenr }
end

local function find_paragraph_boundary(direction)
  if math.abs(direction) ~= 1 then
    -- should error
    return
  end
  local limit = direction == 1 and vim.fn.line("w$") or vim.fn.line("w0")

  local linenr = vim.api.nvim_win_get_cursor(0)[1]
  local line = get_line(linenr)

  while linenr ~= limit and isempty(line) do
    linenr = linenr + direction
    line = get_line(linenr)
  end

  while linenr ~= limit and not isempty(line) do
    linenr = linenr + direction
    line = get_line(linenr)
  end

  return linenr ~= limit and linenr or nil
end

function M.paragraph_signs()
  return {
    ["paragraph_prev"] = find_paragraph_boundary(-1),
    ["paragraph_next"] = find_paragraph_boundary(1),
  }
end

return M
