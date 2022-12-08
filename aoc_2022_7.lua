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

-- Part 1 function
function part_one(lines)
  treeMap = {}
  currDir = ""
  for k,v in pairs(lines) do
    if starts(v, "$") then
      if starts(v, "$ cd") then
        dirName = string.match(v, ".* (.*)")
        if(dirName ~= "/") then
          if(dirName == "..") then
            currDir = string.match(currDir, "(.*/).*/")
          else 
            currDir = currDir .. dirName .. "/"
          end
        else 
          currDir = "/"
        end
        if(treeMap[currDir] == nil) then
          treeMap[currDir] = 0
        end 
      end
    else if(string.find(v, "%d+")) then
      for i=1, #currDir do
        if string.sub(currDir,i,i) == "/" then
          treeMap[string.sub(currDir,1,i)] = treeMap[string.sub(currDir,1,i)] + tonumber(string.match(v, "%d+"))
        end
      end
    end
   end
  end
  totalSum = 0
  for k, v in pairs(treeMap) do
    if(v <= 100000) then
      totalSum = totalSum +v
    end
  end
  return totalSum
end



-- Part 2 function
function part_two(lines)

  treeMap = {}
  currDir = ""
  for k,v in pairs(lines) do
    if starts(v, "$") then
      if starts(v, "$ cd") then
        dirName = string.match(v, ".* (.*)")
        if(dirName ~= "/") then
          if(dirName == "..") then
            currDir = string.match(currDir, "(.*/).*/")
          else 
            currDir = currDir .. dirName .. "/"
          end
        else 
          currDir = "/"
        end
        if(treeMap[currDir] == nil) then
          treeMap[currDir] = 0
        end 
      end
    else if(string.find(v, "%d+")) then
      for i=1, #currDir do
        if string.sub(currDir,i,i) == "/" then
          treeMap[string.sub(currDir,1,i)] = treeMap[string.sub(currDir,1,i)] + tonumber(string.match(v, "%d+"))
        end
      end
    end
   end
  end
  
  usedSpace = treeMap["/"]
  unusedSpace = 70000000 - usedSpace
  neededSpace = 30000000 - unusedSpace
  
  totalSum = 9999999999999999 
  for k, v in pairs(treeMap) do
    if(v > neededSpace) then
      if(v < totalSum) then
        totalSum = v
      end
    end
  end
  return totalSum
end


file = 'params_7_1.txt'
lines = read_file(file)
print('Example Part 1: ' .. part_one(lines))
print('Example Part 2: ' .. part_two(lines))

print('--------------------------')
file = 'params_7_2.txt'
lines = read_file(file)
print('Real Part 1: ' .. part_one(lines))
print('Real Part 2: ' .. part_two(lines))
