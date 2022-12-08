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

function createMap(lines)
  treeMap = {}
  countMap = {}
  rightMap = {}
  downMap = {}
  upMap = {}
  for k,v in pairs(lines) do
    treeMap[k] = {}
    countMap[k] = {}
    rightMap[k] = {}
    downMap[k] = {}
    upMap[k] = {}
    for i=1, #v do
      treeMap[k][i] = tonumber(string.sub(v, i, i))
      countMap[k][i] = 0
      rightMap[k][i] = 0
      downMap[k][i] = 0
      upMap[k][i] = 0
    end
  end
  return treeMap, countMap, rightMap, downMap, upMap
end

-- Part 1 function
function part_one(lines)
  treeMap, countMap = createMap(lines)
  for i=1, #treeMap do
    left = -1
    for j=1, #treeMap[i] do
      if(treeMap[i][j] > left) then
        left = treeMap[i][j]
        countMap[i][j] = 1
      end
    end
  end
  for i=1, #treeMap  do
    right = -1
    for j=#treeMap[i], 1, -1 do
      if(treeMap[i][j] > right) then
        right = treeMap[i][j]
        countMap[i][j] = 1
      end
    end
  end
  for i=1, #treeMap[1] do
    down = -1
    for j=1, #treeMap do
      if(treeMap[j][i] > down) then
        down = treeMap[j][i]
        countMap[j][i] = 1
      end
    end
  end
  for i=1, #treeMap[1] do
    up = -1
    for j=#treeMap, 1, -1 do
      if(treeMap[j][i] > up) then
        up = treeMap[j][i]
        countMap[j][i] = 1
      end
    end
  end
  totalSum = 0
  for i=1, #countMap do
    for j=1, #countMap[i] do
      if(countMap[i][j] == 1) then
        totalSum = totalSum+1
      end
    end
  end
  return totalSum
end



-- Part 2 function
function part_two(lines)
  treeMap, leftMap, rightMap, upMap, downMap = createMap(lines)
  for i=1, #treeMap do
    left = -1
    for j=1, #treeMap[i] do
      for k=j-1, 1, -1 do
        if treeMap[i][j] > treeMap[i][k] then
           leftMap[i][j] = leftMap[i][j] + 1
        else
           leftMap[i][j] = leftMap[i][j] + 1
           break
        end
      end
    end
  end
  for i=1, #treeMap  do
    for j=1, #treeMap[i] do
      for k=j+1, #treeMap[i] do
        if treeMap[i][j] > treeMap[i][k] then
          rightMap[i][j] = rightMap[i][j] + 1
        else
          rightMap[i][j] = rightMap[i][j] + 1
          break
        end
      end
    end
  end
  for i=1, #treeMap[1] do
    for j=1, #treeMap  do
     for k=j+1, #treeMap do
        if treeMap[j][i] > treeMap[k][i] then
          downMap[j][i] = downMap[j][i] + 1
        else
          downMap[j][i] = downMap[j][i] + 1
          break
        end
      end
    end
  end
  for i=1, #treeMap[1] do
    for j=1, #treeMap do
      for k=j-1, 1, -1  do
        if treeMap[j][i] > treeMap[k][i] then
          upMap[j][i] = upMap[j][i] + 1
        else
          upMap[j][i] = upMap[j][i] + 1
          break
        end
      end
    end
  end
  totalSum = 0
  for i=1, #leftMap do
    for j=1, #leftMap[i] do
      product = leftMap[i][j] * rightMap[i][j] * upMap[i][j] * downMap[i][j]
      if product > totalSum then
        totalSum = product
      end
    end
  end
  return totalSum 
end


file = 'params_8_1.txt'
lines = read_file(file)
print('Example Part 1: ' .. part_one(lines))
print('Example Part 2: ' .. part_two(lines))

print('--------------------------')
file = 'params_8_2.txt'
lines = read_file(file)
print('Real Part 1: ' .. part_one(lines))
print('Real Part 2: ' .. part_two(lines))
