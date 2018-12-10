# TODO: Write documentation for `Advent3`
module Advent3
  VERSION = "0.1.0"
  lines = File.read_lines("input")
  field = Array(Array(Int32)).new 1024 {
    Array(Int32).new 1024 {
      0
    }
  }
  lines.each do |line|
    match = /#([0-9]+) @ ([0-9]+),([0-9]+): ([0-9]+)x([0-9]+)/.match(line)
    id = match.try &.[1].to_i || 0
    x = match.try &.[2].to_i || 0
    y = match.try &.[3].to_i || 0
    w = match.try &.[4].to_i || 0
    h = match.try &.[5].to_i || 0
    field[x...x+w].map { |row|
      row.map_with_index! { |n, i| (n+1 if i >= y && i < y+h) || n }
    }
  end  
  result = 0
  field.each do |row|
    row.each do |n|
      if n > 1
        result += 1
      end
    end
  end
  puts result
  lines.each do |line|
    match = /#([0-9]+) @ ([0-9]+),([0-9]+): ([0-9]+)x([0-9]+)/.match(line)
    id = match.try &.[1].to_i || 0
    x = match.try &.[2].to_i || 0
    y = match.try &.[3].to_i || 0
    w = match.try &.[4].to_i || 0
    h = match.try &.[5].to_i || 0
    all = true
    field[x...x+w].each do |row|
      row[y...y+h].each do |n|
        if n != 1
          all = false
          break
        end
      end
      if !all
        break
      end
    end
    if all
      puts id
      break
    end
  end  
end
