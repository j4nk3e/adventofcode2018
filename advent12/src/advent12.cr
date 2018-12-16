require "bit_array"

module Advent12
  extend self

  
  g = ".....####....#...######.###.#...##....#.###.#.###.......###.##..##........##..#.#.#..##.##...####.#..##.#................................"
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
  offset = 5
  generations = 20

  def to_bitarray(s : String, size : Int32?)
    size = size || s.size
    a = BitArray.new size
    s.each_char_with_index do |c, i|
      a[i] = c == '#'
    end
    return a
  end

  f = to_bitarray g, 150
  a = alive.map { |l| to_bitarray l, nil }

  def next_gen(f : BitArray, a : Array(BitArray))
    n = BitArray.new f.size
    (0...(f.size - 4)).each do |i|
      cut = f[i, 5]
      if a.any? { |z| z.zip(cut).all? do |q, w| q == w end }
        n[i + 2] = true
      end
    end
    return n
  end

  puts "0 #{f}"
  generations.times do |i|
    f = next_gen(f, a)
    if !(i % 50000000)
      puts "#{i*100/generations}"
    end
  end
  sum = 0
  puts f.each_with_index { |t, i| sum += i-offset if t }
  puts sum
end
