-- date: 2022-12M-06 16:16:00
--[[
------------------------------------------------------------
No 0)
:options

--> Neovim\share\nvim\runtime\optwin.vim
--> "option-window" :

Copy all text (from  " 1 important" to end) to new buffer:
options_option-window.txt :

 1 important

compatible	behave very Vi compatible (not advisable)
 	set nocp	cp
cpoptions	list of flags to specify Vi compatibility
 	set cpo=aABceFs_
paste	paste mode, insert typed text literally
 	set nopaste	paste
...

------------------------------------------------------------
No 1)
Open options_option-window.txt

------------------------------
No 2)
Run this script!

https://github.com/nanotee/nvim-lua-guide#sourcing-lua-files
:luafile "path to"\opt01_opt-window_gr.lua

Example:
:so C:\Users\<user name>\Documents\opt01_opt-window_gr.lua

------------------------------
I want this:
01optionsGroups.txt :

compatible	 1 important
cpoptions	 1 important
paste	 1 important
pastetoggle	 1 important
runtimepath	 1 important
packpath	 1 important
helpfile	 1 important
whichwrap	 2 moving around, searching and patterns
startofline	 2 moving around, searching and patterns
...

-- #########################################################

RESOURCES (Neovim Lua API):

https://www.davekuhlman.org/nvim-lua-info-notes.html
Published
Fri 29 April 2022

https://jacobsimpson.github.io/nvim-lua-manual/docs/buffers-and-windows/

https://github.com/nanotee/nvim-lua-guide

------------------------------------------------------------
NOTE: 1

------------------------------
-- 02:
h luaref-Lib

5  STANDARD LIBRARIES

5.4 - String Manipulation
h luaref-libString

h string.sub
string.sub(s,1,j)` returns a prefix of {s} with length {j}

h string.len
h string.match

h luaref-patterns
- `%a`  represents all letters.
- `%d`  represents all digits.

------------------------------
-- 03:
h lua.txt

---------------
Lua module: vim
h lua-vim

h vim.split
h vim.trim

------------------------------
-- 04:
Nvim API
h api.txt

Options Functions
h api-options
h nvim_buf_set_option

Buffer Functions
h api-buffer
-->
h nvim_buf_set_name
h nvim_buf_line_count
h nvim_buf_get_lines
h nvim_buf_set_lines

Global Functions
h api-global
-->
h nvim_create_buf
h nvim_get_current_line
h nvim_get_current_buf
h nvim_list_bufs
h nvim_notify

------------------------------------------------------------
h buffers

------------------------------------------------------------
Lua Quick Guide -
https://github.com/medwatt/Notes/blob/main/Lua/Lua_Quick_Guide.ipynb
-->
https://github.com/medwatt/Notes/blob/main/programming_languages/lua/lua.md

h luaref-patterns
- `%a`  represents all letters.
- `%d`  represents all digits.
-- %A represents all non-letter characters.

------------------------------------------------------------
--print(string.gsub("pen", "e", "i"))  --> pin

NOTE: 2
]]
------------------------------------------------------------

function Tr_svk1()
	local A = vim.api

	-- ("listed", "") -- Create a new buffer
	-- local bufnr = A.nvim_create_buf(true, false) -- Create a new buffer

	-- A.nvim_buf_set_name(bufnr, "tr_svk_1_" .. t.hour .. "H_" .. t.min .."M_" .. t.sec .. "S.txt") -- Assign a name to the new buffer

	local t = os.date("*t")
	-- print("Hour:", t.hour)
	-- print("Minute:", t.min)
	-- print("Second:", t.sec)

	-- vim.cmd("e temp")
	-- Simple: edit new file "notes.txt"
	-- vim.cmd.edit("notes.txt")
	BName = "tr_svk_1_" .. t.hour .. "H_" .. t.min .. "M_" .. t.sec .. "S.txt"
	vim.cmd.edit(BName)

	vim.cmd([[ normal "+gP ]]) -- "Paste from clipboard = Insert from + register"

	------------------------------
	-- local myTable1
	-- local lines = { "---Start---" }
	-- local option_lines = {}
	--
	-- table.insert(option_lines, line .. ", " .. secondWord1)
	-- vim.list_extend(lines, option_lines)
	-- table.insert(lines, "---END---")
	--
	-- A.nvim_buf_set_lines(bufnr, 0, -1, true, lines)

	------------------------------
	-- A.nvim_buf_set_lines(bufnr, -1, -1, true, { vim.trim(line1) })
	-- A.nvim_buf_set_lines(bufnr, -1, -1, true, {firstWord .. ', ' .. vim.trim(line1)})

	local svk1
	local svk2

	local svk_niti1
	local svk_niti1LC

	local svk_niti2
	local svk_niti2LC

	local words1

	local svk_lok = {}
	local svk_sr = {}
	local svk_svk = {}
	local nit = {}
	local nitSeg = {}

	local lines = {}
	local iBrojac = 0

	local linesNum = A.nvim_buf_line_count(0)
	-- line1 = A.nvim_buf_get_lines(0, row1 - 3, row1 - 2, false)[1] -- only one line

	for row1 = 1, linesNum do -- The range includes both ends.
		local line1 = A.nvim_buf_get_lines(0, row1 - 1, row1, false)[1] -- only one line

		--------------------
		-- TODO: 1

		-- SVK_0...EVA
		if string.match(line1, "^SVK_") then -- `Live`
			table.insert(svk_lok, line1)
		end

		-- Live	SVK_0...EVA
		-- h pattern-atoms
		if string.match(line1, "^Live") and string.match(line1, "\t") then -- `Live`
			words1 = vim.split(line1, "\t")
			if string.match(words1[2], "^SVK_") then
				table.insert(svk_lok, words1[2])
			end
		end

		--------------------
		-- TODO: 2

		-- SR_0...EVA_5
		-- 1-083
		if string.match(line1, "^SR_") then -- `Live`
			table.insert(svk_sr, line1)
			iBrojac = iBrojac + 1

			-- 1-083
			local line2 = A.nvim_buf_get_lines(0, row1, row1 + 1, false)[1] -- only one line

			local words = vim.split(line2, "-")
			local secondWord = words[2]
			local secondWord2 = tonumber(secondWord)
			table.insert(nit, secondWord2)

			if iBrojac == 1 then
				svk_niti1 = "(nit " .. nit[1] .. " FC/PC)"
				svk_niti1LC = "(nit " .. nit[1] .. " LC/PC)"
			end
		end

		--------------------
		-- TODO: 3

		-- SVJETLOVODNI-...
		-- 0..._23
		if string.match(line1, "^SVJETLOVODNI") then -- `Live`
			local line2 = A.nvim_buf_get_lines(0, row1, row1 + 1, false)[1] -- only one line
			table.insert(svk_svk, line2)

			line2 = A.nvim_buf_get_lines(0, row1 + 1, row1 + 2, false)[1] -- only one line

			local words = vim.split(line2, " ")
			local firstWord = words[1]
			-- table.insert(nitSeg, tonumber(firstWord))
			table.insert(nitSeg, firstWord)
		end

		--------------------
	end

	local iSegmentSVK1 = string.find(svk_svk[1], "_", 4)
	local SVKbroj1 = string.sub(svk_svk[1], 1, iSegmentSVK1 - 1) -- substring from position 1 to next '_'
	svk1 = "SVK " .. SVKbroj1

	local iSegmentSVK2 = string.find(svk_svk[#svk_svk], "_", 4)
	local SVKbroj2 = string.sub(svk_svk[#svk_svk], 1, iSegmentSVK2 - 1) -- substring from position 1 to next '_'
	svk2 = "SVK " .. SVKbroj2

	svk_niti2 = "(nit " .. nit[#nit] .. " FC/PC)" -- substring from position 2 to end of secondWord
	svk_niti2LC = "(nit " .. nit[#nit] .. " LC/PC)" -- substring from position 2 to end of secondWord

	--------------------
	--print(string.gsub("pen", "e", "i"))  --> pin
	local sr1 = string.gsub(svk_sr[1], "SR", "")
	sr1 = string.gsub(sr1, string.sub(svk_lok[1], 4), "")

	local sr2 = string.gsub(svk_sr[#svk_sr], "SR", "")
	sr2 = string.gsub(sr2, string.sub(svk_lok[#svk_lok], 4), "")

	table.insert(lines, svk_lok[1])
	table.insert(lines, svk1 .. ", " .. "OR" .. sr1 .. " " .. svk_niti1)
	table.insert(lines, svk1 .. ", " .. "OR" .. sr1 .. " " .. svk_niti1LC)
	table.insert(lines, "")

	table.insert(lines, svk_lok[#svk_lok])
	table.insert(lines, svk2 .. ", " .. "OR" .. sr2 .. " " .. svk_niti2)
	table.insert(lines, svk2 .. ", " .. "OR" .. sr2 .. " " .. svk_niti2LC)
	table.insert(lines, "")

	table.insert(lines, "**********")
	table.insert(lines, svk_sr[1])
	table.insert(lines, svk_svk[1])
	table.insert(lines, nitSeg[1])
	table.insert(lines, "")

	table.insert(lines, svk_svk[#svk_svk])
	table.insert(lines, nitSeg[#nitSeg])
	table.insert(lines, svk_sr[#svk_sr])
	table.insert(lines, "**********")

	table.insert(lines, "")
	table.insert(lines, svk_lok[1])
	table.insert(lines, svk1 .. ", " .. svk_sr[1] .. " " .. svk_niti1)
	table.insert(lines, svk1 .. ", " .. svk_sr[1] .. " " .. svk_niti1LC)
	table.insert(lines, "")

	table.insert(lines, svk_lok[#svk_lok])
	table.insert(lines, svk2 .. ", " .. svk_sr[#svk_sr] .. " " .. svk_niti2)
	table.insert(lines, svk2 .. ", " .. svk_sr[#svk_sr] .. " " .. svk_niti2LC)

	--------------------
	vim.cmd([[ normal ggVGd ]]) -- Delete all!

	-- A.nvim_buf_set_lines(bufnr, 0, -1, true, lines)
	A.nvim_buf_set_lines(0, 0, -1, true, lines)

	-- A.nvim_set_current_buf(bufnr)
	-- A.nvim_set_current_buf(0)

	vim.cmd("w")

	-- Copy first 17 lines
	-- Start from column 1 explicitly
	vim.cmd([[
    normal gg0y17j
  ]])
end
