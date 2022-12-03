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
local file = 'params_3_2.txt'
local lines = lines_from(file)

local totalSum = 0

local priorityArray = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

for k,v in pairs(lines) do
  
  local elfPlay = string.sub(v, 1, string.len(v)/2)
  local iPlay = string.sub(v, string.len(v)/2 + 1, string.len(v))
  local priority = 0;
  for i=1, #elfPlay do
    local c = string.sub(elfPlay, i, i)
    if(string.match(iPlay, c)) then
      priority = string.find(priorityArray, c)
      --print(priority) 
      break
    end
  end
  totalSum = totalSum + priority
end

print(totalSum)
totalSum = 0
print('------------------')
local str1 = nil
local str2 = nil
local str3 = nil
for k, v in pairs(lines) do
  local priority = 0
  if str1 == nil then
    str1 = v
  elseif str2 == nil then
    str2 = v
  else
    str3 = v  
    for i=1, #str1 do
      local c = string.sub(str1, i, i)
      if(string.match(str2, c)) then
        if(string.match(str3, c)) then
        
          priority = string.find(priorityArray, c)
          str1, str2, str3 = nil
          --print(priority) 
          break
        end
      end
    end
  end
  totalSum = totalSum + priority
end

print(totalSum)
