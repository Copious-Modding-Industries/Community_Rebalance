---@diagnostic disable: lowercase-global
-- # Make VSC shut up about globals

-- Nathan injection functions

local ENABLE_LOGGING = false -- change this thing if you want to spam the console

function log(log_table)
	print(table.concat(log_table))
end

function append(file, target, text)
	local content = ModTextFileGetContent(file)
	local first, last = content:find(target, 0, true)
	if not first then
		log({ "INJECTION (APPEND) FAILED: NO HOOK\nFile: ", file, "\nTarget: ", target, "\nText: ", text })
		return
	end
	local before = content:sub(1, last)
	local after = content:sub(last + 1)
	local new = before .. text .. after
	ModTextFileSetContent(file, new)
	if ENABLE_LOGGING then
		log({ "Injected (append) ", text, " in ", file, " at ", target, " causing:\n", new, "\nfrom: \n", content })
	end
	if content == new then
		log({ "INJECTION (APPEND) FAILED: NO CHANGE\nFile: ", file, "\nTarget: ", target, "\nText: ", text })
	end
end

function prepend(file, target, text)
	local content = ModTextFileGetContent(file)
	local first, last = content:find(target, 0, true)
	if not first then
		log({ "INJECTION (PREPEND) FAILED: NO HOOK\nFile: ", file, "\nTarget: ", target, "\nText: ", text })
		return
	end
	local before = content:sub(1, first - 1)
	local after = content:sub(first)
	local new = before .. text .. after
	ModTextFileSetContent(file, new)
	if ENABLE_LOGGING then
		log({ "Injected (prepend) ", text, " in ", file, " at ", target, " causing:\n", new, "\nfrom: \n", content })
	end
	if content == new then
		log({ "INJECTION (PREPEND) FAILED: NO CHANGE\nFile: ", file, "\nTarget: ", target, "\nText: ", text })
	end
end

function replace(file, target, text)
	local content = ModTextFileGetContent(file)
	local first, last = content:find(target, 0, true)
	if not first then
		log({ "INJECTION (REPLACE) FAILED: NO HOOK\nFile: ", file, "\nTarget: ", target, "\nText: ", text })
		return
	end
	local before = content:sub(1, first - 1)
	local after = content:sub(last + 1)
	local new = before .. text .. after
	ModTextFileSetContent(file, new)
	if ENABLE_LOGGING then
		log({ "Injected (replace) ", text, " in ", file, " at ", target, " causing:\n", new, "\nfrom: \n", content })
	end
	if content == new then
		log({ "INJECTION (REPLACE) FAILED: NO CHANGE\nFile: ", file, "\nTarget: ", target, "\nText: ", text })
	end
end

-- File wrapper to make syntax highlighting and stuff work, just to reduce chance of errors.

function append_from_file(file, target_file, text_file)
	local target = ModTextFileGetContent(target_file)
	local text = ModTextFileGetContent(text_file)
	append(file, target, text)
end

function prepend_from_file(file, target_file, text_file)
	local target = ModTextFileGetContent(target_file)
	local text = ModTextFileGetContent(text_file)
	prepend(file, target, text)
end

function replace_from_file(file, target_file, text_file)
	local target = ModTextFileGetContent(target_file)
	local text = ModTextFileGetContent(text_file)
	replace(file, target, text)
end
