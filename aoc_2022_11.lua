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
  monkeyItems = {}
  monkeySymbol = {}
  monkeyModifier = {}
  monkeyTest = {}
  monkeyTrue = {}
  monkeyFalse = {}
  monkeyBusiness = {}
  for i=1, #lines, 7 do 
    monkeyNumber = tonumber(string.match(lines[i], "%d+"))
    items = string.gmatch(lines[i+1], "%d+")
    monkeyItems[monkeyNumber] = {}
    for item in items do
      table.insert(monkeyItems[monkeyNumber], item)
    end
    monkeySymbol[monkeyNumber] = string.match(lines[i+2], "new = old (.+) ")
    monkeyModifier[monkeyNumber] = string.match(lines[i+2], "%d+")
    if(monkeyModifier[monkeyNumber]== nil) then
      monkeyModifier[monkeyNumber] = "old"
    end
    monkeyTest[monkeyNumber] = tonumber(string.match(lines[i+3], "%d+"))
    monkeyTrue[monkeyNumber] = tonumber(string.match(lines[i+4], "%d+"))
    monkeyFalse[monkeyNumber] = tonumber(string.match(lines[i+5], "%d+"))
  end
  for z=1, 20 do
  for k=0, #monkeyItems do
    x = 1
    while x<=#monkeyItems[k] do
      worryLevel = tonumber(monkeyItems[k][x])
      modifier = 0
      if(monkeyModifier[k] == "old") then
        modifier = worryLevel
      else
        modifier = tonumber(monkeyModifier[k])
      end
      if(monkeySymbol[k] == "+") then
        newWorryLevel = worryLevel + modifier 
      elseif(monkeySymbol[k] == "-") then
        newWorryLevel = worryLevel - modifier 
      elseif(monkeySymbol[k] == "/") then
        newWorryLevel = worryLevel / modifier 
      elseif(monkeySymbol[k] == "*") then
        newWorryLevel = worryLevel * modifier 
      end
      print("Monkey " .. k)
      print("  worry level .. " ..worryLevel)
      print("  worry level .. " .. newWorryLevel )
      newWorryLevel =newWorryLevel + .0 
      if(newWorryLevel % monkeyTest[k]==0) then
        table.insert(monkeyItems[monkeyTrue[k]], newWorryLevel)
      else
        table.insert(monkeyItems[monkeyFalse[k]], newWorryLevel)
      end
      table.remove(monkeyItems[k], x)
      if(monkeyBusiness[k] == nil) then
        monkeyBusiness[k] = 0
      end
      monkeyBusiness[k] = monkeyBusiness[k] + 1
    end
  end
  end
  maxSize = 0
  maxSize2 = 0
  for i=0, #monkeyBusiness do
    print(monkeyBusiness[i])
    if(monkeyBusiness[i] > maxSize) then
      maxSize2 = maxSize
      maxSize = monkeyBusiness[i]
    elseif(monkeyBusiness[i] > maxSize2) then
      maxSize2 = monkeyBusiness[i]
    end
  end
  return maxSize * maxSize2
end



-- Part 2 function
function part_two(lines)
  monkeyItems = {}
  monkeySymbol = {}
  monkeyModifier = {}
  monkeyTest = {}
  monkeyTrue = {}
  monkeyFalse = {}
  monkeyBusiness = {}
  leastCommonMultiple =  1
  for i=1, #lines, 7 do 
    monkeyNumber = tonumber(string.match(lines[i], "%d+"))
    items = string.gmatch(lines[i+1], "%d+")
    monkeyItems[monkeyNumber] = {}
    for item in items do
      table.insert(monkeyItems[monkeyNumber], item)
    end
    monkeySymbol[monkeyNumber] = string.match(lines[i+2], "new = old (.+) ")
    monkeyModifier[monkeyNumber] = string.match(lines[i+2], "%d+")
    if(monkeyModifier[monkeyNumber]== nil) then
      monkeyModifier[monkeyNumber] = "old"
    end
    monkeyTest[monkeyNumber] = tonumber(string.match(lines[i+3], "%d+"))
    leastCommonMultiple = leastCommonMultiple * monkeyTest[monkeyNumber]
    monkeyTrue[monkeyNumber] = tonumber(string.match(lines[i+4], "%d+"))
    monkeyFalse[monkeyNumber] = tonumber(string.match(lines[i+5], "%d+"))
  end
  for z=1, 10000 do
  for k=0, #monkeyItems do
    x = 1
    while x<=#monkeyItems[k] do
      worryLevel = tonumber(monkeyItems[k][x])
      modifier = 0
      if(monkeyModifier[k] == "old") then
        modifier = worryLevel
      else
        modifier = tonumber(monkeyModifier[k])
      end
      if(monkeySymbol[k] == "+") then
        newWorryLevel = worryLevel + modifier 
      elseif(monkeySymbol[k] == "-") then
        newWorryLevel = worryLevel - modifier 
      elseif(monkeySymbol[k] == "/") then
        newWorryLevel = worryLevel / modifier 
      elseif(monkeySymbol[k] == "*") then
        newWorryLevel = worryLevel * modifier 
      end
      print("Monkey " .. k)
      print("  worry level .. " ..worryLevel)
      print("  worry level .. " .. newWorryLevel )
      newWorryLevel = newWorryLevel%leastCommonMultiple
      if(newWorryLevel % monkeyTest[k]==0) then
        table.insert(monkeyItems[monkeyTrue[k]], newWorryLevel)
      else
        table.insert(monkeyItems[monkeyFalse[k]], newWorryLevel)
      end
      table.remove(monkeyItems[k], x)
      if(monkeyBusiness[k] == nil) then
        monkeyBusiness[k] = 0
      end
      monkeyBusiness[k] = monkeyBusiness[k] + 1
    end
  end
  end
  maxSize = 0
  maxSize2 = 0
  for i=0, #monkeyBusiness do
    print(monkeyBusiness[i])
    if(monkeyBusiness[i] > maxSize) then
      maxSize2 = maxSize
      maxSize = monkeyBusiness[i]
    elseif(monkeyBusiness[i] > maxSize2) then
      maxSize2 = monkeyBusiness[i]
    end
  end
  return maxSize * maxSize2
end


file = 'params_11_1.txt'
lines = read_file(file)
print('Example Part 1: ' .. part_one(lines))
print('Example Part 2: ' .. part_two(lines))

print('--------------------------')
file = 'params_11_2.txt'
lines = read_file(file)
--print('Real Part 1: ' .. part_one(lines))
print('Real Part 2: ' .. part_two(lines))
