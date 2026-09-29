-- date: 2026_09M_29 09:34:21

-- If by "week of the year" you mean ISO week number (1-53) and you want the corresponding date in Lua/Neovim,
-- Lua doesn't provide a built-in function for that directly.
-- You need to calculate it.

-- If you're using a date library such as plenary, luadate, or vim.time,
-- there may be a shorter solution,
-- but with pure Lua/Neovim the above ISO-week calculation is the standard way.

-- ------------------------------------------------------------
-- You don't need a global function.
-- Map a key directly to an anonymous Lua function.

-- :let maplocalleader
vim.keymap.set("n", "<localleader>w", function()
  -- If the clipboard contains a string and the last 2 characters are the ISO week number,
  -- you can read it, extract the week, calculate the date, and write the result back to the clipboard:

  -- Read clipboard
  local clip = vim.fn.getreg("+")

  -- Extract last 2 digits
  local week = tonumber(clip:match("(%d%d)$"))

  if not week then
    vim.notify("No week number found")
    return
  end

  local year = tonumber(os.date("%Y"))

  local jan4 = os.time({
    year = year,
    month = 1,
    day = 4,
    hour = 12,
  })

  local wday = os.date("*t", jan4).wday
  local monday = jan4 - ((wday + 5) % 7) * 86400

  -- Friday = Monday + 4 days
  local friday = monday + ((week - 1) * 7 + 4) * 86400

  -- Copy result back to clipboard
  vim.fn.setreg("+", os.date("%Y-%m-%d", friday))

  -- vim.notify("Copied: " .. friday)
  vim.notify("Copied: " .. vim.inspect(os.date("%Y-%m-%d", friday)))
  -- print("Copied: " .. date_str)
end, { desc = "Week number to date" })

-- Debug:
-- :lua year = tonumber(os.date("%Y"))
--
-- :lua print(vim.inspect(year))
-- :lua print("year=", vim.inspect(year))
