---@diagnostic disable: lowercase-global
-- # Make VSC shut up about globals

-- Nathan injection functions

function append(file, target, text)
	local content = ModTextFileGetContent(file)
	local first, last = content:find(target, 0, true)
	local before = content:sub(1, last)
	local after = content:sub(last + 1)
	local new = before .. text .. after
	ModTextFileSetContent(file, new)
	if content == new then print("INJECTION (APPEND) FAILED:\nFile: "..file.."\nTarget: "..target.."\nText: "..text) end
end

function prepend(file, target, text)
	local content = ModTextFileGetContent(file)
	local first, last = content:find(target, 0, true)
	local before = content:sub(1, first - 1)
	local after = content:sub(first)
	local new = before .. text .. after
	ModTextFileSetContent(file, new)
	if content == new then print("INJECTION (PREPEND) FAILED:\nFile: "..file.."\nTarget: "..target.."\nText: "..text) end
end

function replace(file, target, text)
	local content = ModTextFileGetContent(file)
	local first, last = content:find(target, 0, true)
	local before = content:sub(1, first - 1)
	local after = content:sub(last + 1)
	local new = before .. text .. after
	ModTextFileSetContent(file, new)
	if content == new then print("INJECTION (REPLACE) FAILED:\nFile: "..file.."\nTarget: "..target.."\nText: "..text) end
end

-- File wrapper to make syntax highlighting and stuff work, just to reduce chance of errors.

function append_from_file(file,target_file,text_file)
	local target = ModTextFileGetContent(target_file)
	local text = ModTextFileGetContent(text_file)
	append(file,target,text)
end

function prepend_from_file(file,target_file,text_file)
	local target = ModTextFileGetContent(target_file)
	local text = ModTextFileGetContent(text_file)
	prepend(file,target,text)
end

function replace_from_file(file,target_file,text_file)
	local target = ModTextFileGetContent(target_file)
	local text = ModTextFileGetContent(text_file)
	replace(file,target,text)
end