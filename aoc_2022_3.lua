local file = 'params_3_2.txt'

-- reads the file
function read_file()
  local lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

-- new code

local priorityArray = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

-- Part 1 function
function part_one(lines)
  local totalSum = 0
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
  return totalSum
end

-- Part 2 function
function part_two(lines)
  local totalSum = 0
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
  return totalSum
end


local lines = read_file()
print(part_one(lines))
print('------------------')
print(part_two(lines))
