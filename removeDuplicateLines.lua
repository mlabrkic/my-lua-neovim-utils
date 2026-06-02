-- date: 2025_05M_26 14:13:07

-- Microsoft Copilot
-- I use NeoVim 0.11. I need Lua API NeoVim script which delete duplicated lines.
-- ==>
-- Here's a simple Lua script for NeoVim 0.11 that removes duplicate lines from the current buffer:

-- How to use:
-- Add this code to your init.lua or a separate Lua file sourced by your config.
-- In NeoVim, run :RemoveDuplicateLines to remove duplicate lines from the current buffer.

-- ############################################################

-- Here’s an updated version of the Lua script that removes duplicate lines
-- and sorts the remaining lines alphabetically in the current buffer:

-- Lua function to remove duplicate lines and sort them
local function remove_duplicates_and_sort()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local seen = {}
	local unique_lines = {}

	for _, line in ipairs(lines) do
		if not seen[line] then
			table.insert(unique_lines, line)
			seen[line] = true
		end
	end

	table.sort(unique_lines)

	vim.api.nvim_buf_set_lines(0, 0, -1, false, unique_lines)
end

-- Create a command to call the function
vim.api.nvim_create_user_command("RemoveDupesAndSort", remove_duplicates_and_sort, {})
