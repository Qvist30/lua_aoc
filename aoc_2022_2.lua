-- http://lua-users.org/wiki/FileInputOutput
function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
function lines_from(file)
  if not file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

-- tests the functions above
local file = 'params_2_2.txt'
local lines = lines_from(file)

local totalSum = 0;

-- print all line numbers and their contents
for k,v in pairs(lines) do
  local elfPlay = string.sub(v, 1, 1)
  local iPlay = string.sub(v, 3, 3) -- don't sue me apple
  local matchSum = 0
  if(iPlay == 'X') then
    matchSum = matchSum + 1
    if(elfPlay == 'A') then
      matchSum = matchSum + 3
    elseif elfPlay == 'C' then
      matchSum = matchSum + 6
    end
  elseif iPlay == 'Y' then
    matchSum = matchSum + 2
    if elfPlay == 'A' then
      matchSum = matchSum +6
    elseif elfPlay == 'B' then
      matchSum = matchSum + 3
    end
  else
    matchSum = matchSum +3
    if elfPlay == 'B' then
      matchSum = matchSum + 6
    elseif elfPlay == 'C' then
      matchSum = matchSum + 3
    end
  end
  totalSum = totalSum + matchSum
end

print(totalSum)

print('-------------')

totalSum = 0

for k,v in pairs(lines) do
  
  local elfPlay = string.sub(v, 1, 1)
  local iPlay = string.sub(v, 3, 3) -- don't sue me apple
  local matchSum = 0
  if(elfPlay == 'A') then
    if iPlay == 'Z' then
      matchSum = matchSum + 6 + 2 -- paper covers rock
    elseif iPlay == 'Y' then
      matchSum = matchSum + 3 + 1 -- rocky mountains
    else
      matchSum = matchSum + 0 + 3 -- rock smashes scissors but I still get 3 points
    end
  elseif elfPlay == 'B' then
    if iPlay == 'Z' then
      matchSum = matchSum + 6 + 3 -- winner winner scissor dinner
    elseif iPlay == 'Y' then
      matchSum = matchSum + 3 + 2 -- legal vs letter still is a tie
    else
      matchSum = matchSum + 0 + 1 -- wait where'd my rock go 
    end
  else
    if iPlay == 'Z' then
      matchSum = matchSum + 6 + 1 -- take that scissors!
    elseif iPlay == 'Y' then
      matchSum = matchSum + 3 + 3 -- scissor me timbers
    else
      matchSum = matchSum + 0 + 2 -- a satisfying cut to end the code
    end
  end
  totalSum = matchSum + totalSum
end

print(totalSum)
