-- reads the file
function read_file(file)
  local lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

function compareChar(str, first, second)
  if(string.sub(str, first, first) ~= string.sub(str, second, second)) then
    return true
  end
  return false
end

-- Part 1 function
function part_one(lines)
  for k,v in pairs(lines) do
    for i=1, #v do
      if(i>=4) then
        if(compareChar(v, i, i-1) and compareChar(v, i, i-2) and compareChar(v, i, i-3) and compareChar(v, i-1, i-2) and compareChar(v, i-1, i-3) and compareChar(v, i-2, i-3)) then
          return i
        end
      end
    end
  end
end

-- Part 2 function
function part_two(lines)

  for k,v in pairs(lines) do
    for i=1, #v do
      if(i>=14) then
        for j=13, 0, -1 do
          for k=13, 0, -1 do
            if(j~=k) then
              if(compareChar(v, i-j, i-k)== false) then
                goto label
              end
            end
            if(j==0 and k==0) then
              return i
            end
          end
        end
        ::label::
      end
    end
  end
end


file = 'params_6_1.txt'
lines = read_file(file)
print('Example Part 1: ' .. part_one(lines))
print('Example Part 2: ' .. part_two(lines))

print('--------------------------')
file = 'params_6_2.txt'
lines = read_file(file)
print('Real Part 1: ' .. part_one(lines))
print('Real Part 2: ' .. part_two(lines))
