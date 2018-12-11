# TODO: Write documentation for `Advent11`
module Advent11
  extend self

  sn = 7403
  max = 0
  max_coords = {0, 0}
  powers = Array(Array(Int32)).new 300 { |x| Array(Int32).new 300 { |y| power(x, y, sn) } }
  sums = Array(Array(Int32)).new 300 { |x| Array(Int32).new 300 { |y| powers[(0..x)].map { |r| r[0..y].sum }.sum } }
  (0...300).each do |x|
    puts x
    (0...300).each do |y|
      (0...(300 - Math.max(x, y))).each do |s|
        # Area of AD 
        #         BC = C-B-D+A
        sum = sums[x + s][y + s] - sums[x + s][y] - sums[x][y + s] + sums[x][y]
        if sum > max
          max = sum
          max_coords = {x + 1, y + 1, s} # 1 based coordinates
        end
      end
    end
  end

  puts max_coords, max

  # (1..300).each do |x|
  #   puts x
  #   (1..300).each do |y|
  #     (0..(300 - Math.max(x, y))).each do |s|
  #       sum = 0
  #       (0..s).each do |a|
  #         (0..s).each do |b|
  #           sum += power(x + a, y + b, sn)
  #         end
  #       end
  #       if sum > max
  #         max = sum
  #         max_coords = {x, y, s}
  #       end
  #     end
  #   end
  # end

  # puts max_coords, max

  def power(x : Int32, y : Int32, sn : Int32)
    rack_id = x + 10
    power = rack_id * y
    power += sn
    power *= rack_id
    power = (power % 1000) / 100
    power -= 5
    return power
  end
end
