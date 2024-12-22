--  Input Parsing
local parseInput = function(inputFile, method)
	local file = io.open(inputFile, method)

	if not file then
		error("Error opening the file!" .. inputFile)
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

local inputString = io.read()
local methodString = "r"

local file, a, b = parseInput(inputString, methodString)

table.sort(a)
table.sort(b)

local calculateDifferense = function(left_array, right_array)
	local difference = 0

	for i = 1, #left_array do
		local left = left_array[i]
		local right = right_array[i]

		difference = difference + math.abs(left - right) --left - right
	end

	return difference
end

local difference = calculateDifferense(a, b)

print(difference)

cleanup(file)
