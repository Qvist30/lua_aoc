-- reads the file
function read_file(file)
  local lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

function starts(str,start)
   return string.sub(str,1,string.len(start))==start
end

function getValues(signalMap, ...)
  arg = {...}
  totalSum = 0
  for i=1, #arg do
    totalSum = totalSum + (signalMap[arg[i]] * arg[i])
  end
  return totalSum
end

-- Part 1 function
function part_one(lines)
  signalMap = {}
  x = 1
  cycle = 1
  signalMap[cycle] = x
  cycle = cycle + 1
  for k, v in pairs(lines) do
    if(string.find(v,"%d+")) then
      signalMap[cycle] = x
      cycle = cycle + 1
      newSignal = tonumber(string.match(v,"%-?%d+"))
      x = x + newSignal
      signalMap[cycle] = x
      cycle = cycle + 1
    else 
      signalMap[cycle] = x
      cycle = cycle + 1  
    end
  end
  totalSum = getValues(signalMap, 20, 60, 100, 140, 180, 220)
  return totalSum
end



-- Part 2 function
function part_two(lines)
  signalMap = {}
  x = 1
  cycle = 1
  position = 0
  signalMap[0] = {}
  if(position == x or position == x-1 or position == x+1) then
    signalMap[0][position] = "#"
  else
    signalMapi[0][position] = "."
  end
  cycle = cycle + 1
  for k, v in pairs(lines) do
    position = (cycle-1) % 40
    row = math.floor((cycle-1)/40)
    if(signalMap[row] == nil) then
      signalMap[row] = {}
    end
    if(string.find(v,"%d+")) then
      print("B" .. row .. " " .. position .. " " ..x)
      if(position == x or position == x-1 or position == x+1) then
        signalMap[row][position] = "#"
      else
        signalMap[row][position] = "."
      end
      cycle = cycle + 1
      position = (cycle -1)% 40 
      newSignal = tonumber(string.match(v,"%-?%d+"))
    row = math.floor((cycle-1)/40)
      if(signalMap[row] == nil) then
        signalMap[row] = {}
      end
      x = x + newSignal
      print("A " .. row .. " " .. position .. " " ..x)
      if(position == x or position == x-1 or position == x+1) then
        signalMap[row][position] = "#"
      else
        signalMap[row][position] = "."
      end
      cycle = cycle + 1
      position = (cycle-1)%40
      row = math.floor((cycle-1)/40)
    else
      print(row .. " " .. position .. " " ..x)
      if(position == x or position == x-1 or position == x+1) then
        signalMap[row][position] = "#"
      else
        signalMap[row][position] = "."
      end
      cycle = cycle + 1
    end
  end
  for i=0,5 do
    s = i..": "
    for j=0, 39  do
      s = s .. signalMap[i][j]
    end
    print(s)
  end
end


file = 'params_10_1.txt'
lines = read_file(file)
print('Example Part 1: ' .. part_one(lines))
--print('Example Part 2: ' .. part_two(lines))

print('--------------------------')
file = 'params_10_2.txt'
lines = read_file(file)
print('Real Part 1: ' .. part_one(lines))
print('Real Part 2: ' .. part_two(lines))
