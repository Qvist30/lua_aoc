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
  stacks = {}
  inFirstPart = true
  inSecondPart = false
  for k,v in pairs(lines) do
    if inFirstPart == true then
      for i=0, #v, 4 do
        s = string.sub(v, i+1,i+4)
        if(string.find(s, "%a")) then
           stacknum = math.floor(i/4)
           if(stacks[stacknum] == nil) then
             stacks[stacknum] = {} 
           end
           table.insert(stacks[stacknum], string.match(s, "%a"))
        elseif(string.find(s, "%d")) then
          inFirstPart = false
          break
        end
      end
    else
      inSecondPart = true
    end
    if inSecondPart == true then
      if(string.find(v, "%d")) then
        first, second, third, fourth, fifth = string.find(v, "move (%d+) from (%d) to (%d)")
        for i=1, third do
          pop = table.remove(stacks[fourth-1], 1)
          table.insert(stacks[fifth-1], 1, pop)
        end
      end
    end
  end
  s = ""
  for i=0, #stacks do
    s = s ..table.remove(stacks[i], 1)
  end 
  return s
end

-- Part 2 function
function part_two(lines)
  local totalSum = 0
  stacks = {}
  inFirstPart = true
  inSecondPart = false
  for k,v in pairs(lines) do
    if inFirstPart == true then
      for i=0, #v, 4 do
        s = string.sub(v, i+1,i+4)
        if(string.find(s, "%a")) then
           stacknum = math.floor(i/4)
           if(stacks[stacknum] == nil) then
             stacks[stacknum] = {} 
           end
           table.insert(stacks[stacknum], string.match(s, "%a"))
        elseif(string.find(s, "%d")) then
          inFirstPart = false
          break
        end
      end
    else
      inSecondPart = true
    end
    if inSecondPart == true then
      if(string.find(v, "%d")) then
        first, second, third, fourth, fifth = string.find(v, "move (%d+) from (%d) to (%d)")
        pop ={}
        for i=third, 1, -1 do
          pop[i] = table.remove(stacks[fourth-1], 1)
        end
        for i=1, third do
          table.insert(stacks[fifth-1], 1, pop[i])
        end
      end
    end
  end
  s = ""
  for i=0, #stacks do
    s = s ..table.remove(stacks[i], 1)
  end 
    
  return s
end


file = 'params_5_1.txt'
lines = read_file(file)
print('Example Part 1: ' .. part_one(lines))
print('Example Part 2: ' .. part_two(lines))

print('--------------------------')
file = 'params_5_2.txt'
lines = read_file(file)
print('Real Part 1: ' .. part_one(lines))
print('Real Part 2: ' .. part_two(lines))
