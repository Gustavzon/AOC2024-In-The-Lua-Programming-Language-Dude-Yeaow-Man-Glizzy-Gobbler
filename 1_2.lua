--Part 2

--  Input Parsing
local parseInput = function(inputFileAndItsNameAsAString, method)
	local file = io.open(inputFileAndItsNameAsAString, method)

	if not file then
		error("Error opening the file!" .. inputFileAndItsNameAsAString)
	end

	print("File opened")

	local a, b = {}, {}
	local index = 1

	for i in file:lines() do
		local space_start, space_end = string.find(i, "   ")

		if not space_start or not space_end then
			error("Space: " .. space_start .. space_end)
		end

		local l = string.sub(i, 1, space_start)
		a[index] = tonumber(l)
		local r = string.sub(i, space_end)
		b[index] = tonumber(r)
		index = index + 1
	end

	return file, a, b
end

local cleanup = function(inputFile)
	if inputFile then
		inputFile:close()
		print("file closed")
	else
		error("inputFile is not a file!" .. inputFile)
	end
end

local printTable = function(t)
	for index, value in pairs(t) do
		print("Index: " .. index .. " Value: " .. value)
	end
end

local calculateOccurances = function(t)
	local counts = {}
	for _, value in ipairs(t) do
		if not counts[value] then
			counts[value] = 1
		else
			counts[value] = counts[value] + 1
		end
	end

	return counts
end

local calculateTotal = function(t1, counts)
	local total = 0
	for _, value in pairs(t1) do
		local currentValue = value
		total = total + currentValue * (counts[currentValue] or 0)
	end

	return total
end

local inputString = arg[1]
local method = arg[2]

local file, left, right = parseInput(inputString, method)
local result = calculateOccurances(right)

local total = calculateTotal(left, result)

print(total)

cleanup(file)
