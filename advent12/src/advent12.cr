require "bit_array"

module Advent12
  extend self

  g = "####....#...######.###.#...##....#.###.#.###.......###.##..##........##..#.#.#..##.##...####.#..##.#"
  alive = "##.##
.#...
...##
.#..#
.#.#.
.#.##
.###.
#..##
#.#..
#.#.#
#.##.
##...
.####
#.###
#####".lines
  generations = 1000

  def to_bitarray(s : String, size : Int32?, offset : Int32?)
    size = size || s.size
    offset = offset || 0
    a = BitArray.new size
    s.each_char_with_index do |c, i|
      a[i + offset] = c == '#'
    end
    return a
  end

  f = to_bitarray g, 2500, 1000
  a = alive.map { |l| to_bitarray l, nil, nil }

  def next_gen(f : BitArray, a : Array(BitArray))
    n = BitArray.new f.size
    (0...(f.size - 4)).each do |i|
      cut = f[i, 5]
      if a.any? { |z| z.zip(cut).all? do |q, w|
           q == w
         end }
        n[i + 2] = true
      end
    end
    return n
  end

  def to_sum(f : BitArray)
    sum = 0
    f.each_with_index { |t, i| sum += i - 1000 if t }
    return sum.to_i64
  end

  puts "0 #{f}"
  diff = 0
  prev = to_sum(f)
  generations.times do |i|
    f = next_gen(f, a)
    if (i % 100) == 0
      current = to_sum(f)
      diff = (current - prev) / 100
      puts diff
      prev = current
    end
  end
  tt = to_sum(f)
  puts tt
  puts "sum after 50000000000 = #{tt + (50000000000 - 1000)*diff}"
end
