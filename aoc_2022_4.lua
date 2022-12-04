-- reads the file
function read_file(file)
  local lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

-- new code
-- priorityArray = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

-- Part 1 function
function part_one(lines)
  local totalSum = 0
  for k,v in pairs(lines) do
    
    for firstPartnerStart, firstPartnerEnd, secondPartnerStart, secondPartnerEnd in string.gmatch(v, '([0-9]*)-([0-9]*),([0-9]*)-([0-9]*)') do
      firstPartnerStart = tonumber(firstPartnerStart)
      firstPartnerEnd = tonumber(firstPartnerEnd)
      secondPartnerStart = tonumber(secondPartnerStart)
      secondPartnerEnd = tonumber(secondPartnerEnd)
      if(firstPartnerStart <= secondPartnerStart and firstPartnerEnd >= secondPartnerEnd) then
        totalSum = totalSum +1
      elseif(secondPartnerStart <= firstPartnerStart and secondPartnerEnd >= firstPartnerEnd) then
        totalSum = totalSum +1
      end
      
    end
  end 
  return totalSum
end

-- Part 2 function
function part_two(lines)
  local totalSum = 0
  for k,v in pairs(lines) do
    
    for firstPartnerStart, firstPartnerEnd, secondPartnerStart, secondPartnerEnd in string.gmatch(v, '([0-9]*)-([0-9]*),([0-9]*)-([0-9]*)') do
      firstPartnerStart = tonumber(firstPartnerStart)
      firstPartnerEnd = tonumber(firstPartnerEnd)
      secondPartnerStart = tonumber(secondPartnerStart)
      secondPartnerEnd = tonumber(secondPartnerEnd)
      if(firstPartnerStart <= secondPartnerEnd and firstPartnerEnd >= secondPartnerStart) then
        totalSum = totalSum +1
      elseif(secondPartnerStart <= firstPartnerEnd and secondPartnerEnd >= firstPartnerStart) then
        totalSum = totalSum +1
      end
      
    end
  end
  return totalSum
end


file = 'params_4_1.txt'
lines = read_file(file)
print('Example Part 1: ' .. part_one(lines))
print('Example Part 2: ' .. part_two(lines))

print('--------------------------')
file = 'params_4_2.txt'
lines = read_file(file)
print('Real Part 1: ' .. part_one(lines))
print('Real Part 2: ' .. part_two(lines))
