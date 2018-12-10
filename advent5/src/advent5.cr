module Advent5
  extend self
  
  def react(input : String) : String
    result = ""
    input.each_char do |c|
      last = if result.empty?
               ""
             else
               result[-1].to_s
             end
      if last.compare(c.to_s, case_insensitive = true) == 0 && last.compare(c.to_s) != 0
        result = result.rchop
      else
        result = result + c
      end
    end
    return result
  end

  input = File.read("input")
  result = react(input)
  minSize = result.size
  result.chars.to_set.each do |c|
    try = result.delete(c.upcase).delete(c.downcase)
    r = react(try)
    if r.size < minSize
      minSize = r.size
    end
  end
  puts minSize
end
