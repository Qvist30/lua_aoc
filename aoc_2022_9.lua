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
  hX, tX = 0, 0
  hY, tY = 0, 0
  visitedGrid = {}
  visitedGrid[0] = {}
  visitedGrid[0][0] = 1
  for k, v in pairs(lines) do
    --print(v)
    if(starts(v, "U")) then
      for i=1, tonumber(string.match(v, "%d+")) do
        hX = hX+1
        if(hX-tX > 1) then
          tX = tX + 1
          if(hY < tY) then
            tY = tY -1
          elseif(hY > tY) then
            tY = tY +1  
          end
        end
        if(visitedGrid[tX] == nil) then
          visitedGrid[tX] = {}
        end
        visitedGrid[tX][tY] = 1
        --print(tX .." " .. tY)
      end
    end
    if(starts(v, "R")) then
      for i=1, tonumber(string.match(v, "%d+")) do
        hY = hY+1
        if(hY-tY > 1) then
          tY = tY + 1
          if(hX < tX) then
            tX = tX -1
          elseif(hX > tX) then
            tX = tX +1  
          end
        end
        if(visitedGrid[tX] == nil) then
          visitedGrid[tX] = {}
        end
        visitedGrid[tX][tY] = 1
        --print(tX .." " .. tY)
      end
    end
    if(starts(v, "D")) then
      for i=1, tonumber(string.match(v, "%d+")) do
        hX = hX-1
        if(tX - hX > 1) then
          tX = tX - 1
          if(hY < tY) then
            tY = tY -1
          elseif(hY > tY) then
            tY = tY +1  
          end
        end
        if(visitedGrid[tX] == nil) then
          visitedGrid[tX] = {}
        end
        visitedGrid[tX][tY] = 1
        --print(tX .." " .. tY)
      end
    end
    if(starts(v, "L")) then
      for i=1, tonumber(string.match(v, "%d+")) do
        hY = hY-1
        if(tY-hY > 1) then
          tY = tY - 1
          if(hX < tX) then
            tX = tX -1
          elseif(hX > tX) then
            tX = tX +1  
          end
        end
        if(visitedGrid[tX] == nil) then
          visitedGrid[tX] = {}
        end
        visitedGrid[tX][tY] = 1
        --print(tX .." " .. tY)
      end
    end
  end
  totalSum = 0
  for k, v in pairs(visitedGrid) do
    for x,y in pairs(visitedGrid[k]) do
      if(visitedGrid[k][x] == 1) then
        totalSum = totalSum + 1
      end
    end
  end
  return totalSum
end

function moveDown(x0, x1, y0, y1)
  dx, dy = 0, 0
  if(x1-x0 > 1) then
    x1 = x1 - 1
    dx = -1
  end
  if(x1-x0 > 1 or dx==-1) then
    if(y1-y0 > 0) then
      y1 = y1 -1
      dy = -1
    elseif(y0- y1> 0) then
      y1 = y1 + 1    
      dy = 1
   end
  end
  return x1, y1, dx, dy
end

function moveUp(x0, x1, y0, y1)
  dx, dy = 0, 0
  if(x0 -x1 > 1) then
    x1 = x1 + 1
    dx = 1
  end
  if(x0-x1 > 1 or dx ==1) then
    if(y1-y0 > 0) then
      y1 = y1 -1
      dy = -1
    elseif(y0-y1 > 0) then
      y1 = y1 + 1
      dy = 1
    end
  end
  return x1, y1, dx, dy
end

function moveLeft(x0, x1, y0, y1)
  dx, dy = 0, 0
  if(y1-y0 > 1) then
    y1 = y1 - 1
    dy = -1
  end
  if(y1-y0>1 or dy ==-1) then
    if(x1 -x0 > 0) then
      x1 = x1 -1
      dx = -1
    elseif(x0-x1>0) then
      x1 = x1 + 1
      dx = 1
   end
  end
  return x1, y1, dx, dy
end

function moveRight(x0, x1, y0, y1)
  dx, dy = 0, 0
  if(y0-y1 > 1) then
    y1 = y1 + 1
    dy = 1
  end
  if(y0-y1 > 1 or dy ==1) then
    if(x1 -x0 >0) then
      x1 = x1 -1
      dx = -1
    elseif(x0 -x1 > 0) then
      x1 = x1 + 1
      dx = 1
   end
  end
  return x1, y1, dx, dy
end

function move(x0, x1, y0, y1, dx, dy)
 
  rdx, rdy, xdx,xdy = 0, 0, 0, 0 
  if(dx == 1) then
    x1, y1, rdx, rdy = moveUp(x0, x1, y0, y1)
  elseif(dx == -1) then
    x1, y1, rdx, rdy = moveDown(x0, x1, y0, y1)
  end
  if(dy == 1) then
    x1, y1, xdx, xdy = moveRight(x0, x1, y0, y1)
  elseif(dy == -1) then
    x1, y1, xdx, xdy = moveLeft(x0, x1, y0, y1)
  end
  return x1, y1, rdx + xdx, rdy+xdy
end

-- Part 2 function
function part_two(lines)

  hX, x1, x2, x3, x4, x5, x6, x7, x8, x9 = 0, 0, 0, 0, 0, 0, 0, 0, 0,0
  hY, y1, y2, y3, y4, y5, y6, y7, y8, y9 = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  visitedGrid = {}
  visitedGrid[0] = {}
  visitedGrid[0][0] = 1
  for k, v in pairs(lines) do
    print(v)
    if(starts(v, "U")) then
      for i=1, tonumber(string.match(v, "%d+")) do
        hX = hX +1
        dx, dy = 1, 0
        x1, y1, dx,dy = move(hX, x1, hY, y1, dx, dy)
        x2, y2, dx, dy = move(x1, x2, y1, y2, dx, dy)
        x3, y3, dx, dy = move(x2, x3, y2, y3, dx, dy)
        x4, y4, dx, dy = move(x3, x4, y3, y4, dx, dy)
        --print(dx .. " " .. dy)
        x5, y5, dx, dy = move(x4, x5, y4, y5, dx, dy)
        x6, y6, dx, dy = move(x5, x6, y5, y6, dx, dy)
        x7, y7, dx, dy  = move(x6, x7, y6, y7, dx, dy)
        x8, y8, dx, dy  = move(x7, x8, y7, y8, dx, dy)
        x9, y9, dx, dy = move(x8, x9, y8, y9, dx, dy) 
        if(visitedGrid[x9] == nil) then
          visitedGrid[x9] = {}
        end
        visitedGrid[x9][y9] = 1
	print(hX .. "," .. hY .. " " .. x1 .. "," .. y1.. " ".. x2 .."," ..  y2 .. " " .. x3.. "," .. y3.." " ..x4..","..y4 .." "..x5.."," .. y5)
      end
    end    
    if(starts(v, "R")) then
      for i=1, tonumber(string.match(v, "%d+")) do
        hY = hY+1
        dx, dy = 0,1
        x1, y1, dx,dy = move(hX, x1, hY, y1, dx, dy)
        x2, y2, dx, dy = move(x1, x2, y1, y2, dx, dy)
        x3, y3, dx, dy = move(x2, x3, y2, y3, dx, dy)
        x4, y4, dx, dy = move(x3, x4, y3, y4, dx, dy)
        x5, y5, dx, dy = move(x4, x5, y4, y5, dx, dy)
        x6, y6, dx, dy = move(x5, x6, y5, y6, dx, dy)
        x7, y7, dx, dy  = move(x6, x7, y6, y7, dx, dy)
        x8, y8, dx, dy  = move(x7, x8, y7, y8, dx, dy)
        x9, y9, dx, dy = move(x8, x9, y8, y9, dx, dy)
        if(visitedGrid[x9] == nil) then
          visitedGrid[x9] = {}
        end
        visitedGrid[x9][y9] = 1
	print(hX .. "," .. hY .. " " .. x1 .. "," .. y1.. " ".. x2 .."," ..  y2 .. " " .. x3.. "," .. y3.." " ..x4..","..y4 .." "..x5.."," .. y5)
      end
    end
    if(starts(v, "D")) then
      for i=1, tonumber(string.match(v, "%d+")) do
        hX = hX-1
        dx, dy = -1, 0
        x1, y1, dx,dy = move(hX, x1, hY, y1, dx, dy)
        x2, y2, dx, dy = move(x1, x2, y1, y2, dx, dy)
        x3, y3, dx, dy = move(x2, x3, y2, y3, dx, dy)
        x4, y4, dx, dy = move(x3, x4, y3, y4, dx, dy)
        x5, y5, dx, dy = move(x4, x5, y4, y5, dx, dy)
        x6, y6, dx, dy = move(x5, x6, y5, y6, dx, dy)
        x7, y7, dx, dy  = move(x6, x7, y6, y7, dx, dy)
        x8, y8, dx, dy  = move(x7, x8, y7, y8, dx, dy)
        x9, y9, dx, dy = move(x8, x9, y8, y9, dx, dy)
        if(visitedGrid[x9] == nil) then
          visitedGrid[x9] = {}
        end
        visitedGrid[x9][y9] = 1
	print(hX .. "," .. hY .. " " .. x1 .. "," .. y1.. " ".. x2 .."," ..  y2 .. " " .. x3.. "," .. y3.." " ..x4..","..y4 .." "..x5.."," .. y5)
      end
    end   
    if(starts(v, "L")) then
      for i=1, tonumber(string.match(v, "%d+")) do
        hY = hY-1
        dx, dy =0, -1
        x1, y1, dx, dy = move(hX, x1, hY, y1, dx, dy)
        x2, y2, dx, dy = move(x1, x2, y1, y2, dx, dy)
        x3, y3, dx, dy = move(x2, x3, y2, y3, dx, dy)
        x4, y4, dx, dy = move(x3, x4, y3, y4, dx, dy)
        x5, y5, dx, dy = move(x4, x5, y4, y5, dx, dy)
        x6, y6, dx, dy = move(x5, x6, y5, y6, dx, dy)
        x7, y7, dx, dy  = move(x6, x7, y6, y7, dx, dy)
        x8, y8, dx, dy  = move(x7, x8, y7, y8, dx, dy)
        x9, y9, dx, dy = move(x8, x9, y8, y9, dx, dy)
        if(visitedGrid[x9] == nil) then
          visitedGrid[x9] = {}
        end
        visitedGrid[x9][y9] = 1

	print(hX .. "," .. hY .. " " .. x1 .. "," .. y1.. " ".. x2 .."," ..  y2 .. " " .. x3.. "," .. y3.." " ..x4..","..y4 .." "..x5.."," .. y5)
      end
    end
  end
  totalSum = 0
  for k, v in pairs(visitedGrid) do
    for x,y in pairs(visitedGrid[k]) do
      if(visitedGrid[k][x] == 1) then
        totalSum = totalSum + 1
      end
    end
  end
  return totalSum  

end


file = 'params_9_1.txt'
lines = read_file(file)
print('Example Part 1: ' .. part_one(lines))
file = 'params_9_3.txt'
lines = read_file(file)
print('Example Part 2: ' .. part_two(lines))

print('--------------------------')
file = 'params_9_2.txt'
lines = read_file(file)
print('Real Part 1: ' .. part_one(lines))
print('Real Part 2: ' .. part_two(lines))

