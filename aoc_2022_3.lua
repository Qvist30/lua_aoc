function lines_from(file)
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
  
  local firstHalf = string.sub(v, 1, #v/2)
  local secondHalf = string.sub(v, #v/2 + 1, #v)
  local priority = 0;
  for i=1, #firstHalf do
    local c = string.sub(firstHalf, i, i)
    if(string.match(secondHalf, c)) then
      priority = string.find(priorityArray, c)
      break
    end
  end
  totalSum = totalSum + priority
end

print(totalSum)
totalSum = 0
print('------------------')
for i =1, #lines,3 do
  local priority = 0
  local str1, str2, str3 = lines[i], lines[i+1], lines[i+2]
  for i=1, #str1 do
    local c = string.sub(str1, i, i)
    if(string.match(str2, c) and string.match(str3, c)) then
      priority = string.find(priorityArray, c)
      break
    end
  end
  totalSum = totalSum + priority
end

print(totalSum)
