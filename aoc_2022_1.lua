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
local file = 'aoc_1_2_params.txt'
local lines = lines_from(file)

local maxValue1 = 0;
local maxValue2 = 0;
local maxValue3 = 0;
local tempValue = 0;

-- print all line numbers and their contents
for k,v in pairs(lines) do
  if(string.len(v) == 0) then
    if tempValue > maxValue1 then
      maxValue3 = maxValue2
      maxValue2 = maxValue1
      maxValue1 = tempValue
    elseif tempValue > maxValue2 then
      maxValue3 = maxValue2
      maxValue2 = tempValue
    elseif tempValue > maxValue3 then
      maxValue3 = tempValue
    end
    tempValue =0
  else
    tempValue = tempValue +tonumber(v)
  end
end

print(maxValue1+maxValue2+maxValue3)
