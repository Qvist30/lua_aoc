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
local file = 'params.txt'
local lines = lines_from(file)

local numIncreased = 0;
local tempValue;

-- print all line numbers and their contents
for k,v in pairs(lines) do
  v = tonumber(v)
  if(type(tempValue) == "number" and v  > tempValue) then
    numIncreased = numIncreased +1
    
  end
  tempValue = tonumber(v)
end

print(numIncreased)

local tempOne
local tempTwo
local tempThree
local tempSum
local numIncreasedSum = 0

for k,v in pairs(lines) do
  v = tonumber(v)
  if(type(tempOne) == "nil") then
    tempOne = v
  elseif(type(tempTwo) == "nil") then
    tempTwo = tempOne
    tempOne = v
  elseif(type(tempThree) == "nil") then
    tempThree = tempTwo
    tempTwo = tempOne
    tempOne = v
    tempSum = tempThree + tempTwo + tempOne
  else
    tempThree = tempTwo
    tempTwo = tempOne
    tempOne = v
    actualSum = tempThree + tempTwo + tempOne
    if(actualSum > tempSum) then
      numIncreasedSum = numIncreasedSum +1
    end
    tempSum = actualSum
  end
    
end

print(numIncreasedSum)
