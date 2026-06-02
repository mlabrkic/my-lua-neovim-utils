-- Delete all CSV columns except the last one in the current buffer
local function keep_last_csv_column()
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  for i, line in ipairs(lines) do
    -- Skip empty lines
    if line ~= "" then
      -- Extract text after the last comma (or the whole line if none)
      -- local last_col = line:match(".*,(.*)$") or line

      -- Match everything after the last TAB
      local last_col = line:match(".*\t(.*)$") or line

      lines[i] = last_col
    end
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

-- Expose as a command
vim.api.nvim_create_user_command(
  "QcsvKeepLastColumn",
  keep_last_csv_column,
  -- { desc = "Remove all CSV columns except the last one" }
  { desc = "Remove all TAB-separated columns except the last one" }
)
