# TODO: Write documentation for `Advent14`
module Advent14
  extend self

  def find
    input = "990941"
    elves = [0, 1]
    output = Deque(Int32).new
    output << 3
    output << 7
    score = ""
    while 1
      sum = 0
      elves.each do |i|
        sum += output[i]
      end
      sum.to_s.each_char do |c|
        output << c.to_i32
        if input.starts_with? (score + c)
          score += c
        else
          score = ""
        end
        if input == score
          return output.size - input.size
        end
      end
      elves.each_with_index do |e, i|
        elves[i] = (e + output[e] + 1) % output.size
      end
      elves.each_with_index do |e, i|
        if elves.count(e) > 1
          elves[i] += 1
        end
      end
    end
  end

  puts find
  # puts ((input)..(input+9)).map { |i| output[i] }.join
end
