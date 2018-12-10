# TODO: Write documentation for `Advent6`
module Advent6
  VERSION = "0.1.0"

  input = File.read_lines("input")
  class Coordinates
    property name = -1
    property area = 0
    property infinite = false
    property distances = Hash(Coordinates, Int32).new
    property x : Int32
    property y : Int32
    def initialize(@x : Int32, @y : Int32)
    end

    def initialize(@x : Int32, @y : Int32, @name : Int32)
    end

    def dist(coords : Coordinates)
      return (coords.x-@x).abs+(coords.y-@y).abs
    end

    def closest()
      min = -1
      s = nil
      @distances.each do |c, d|
        if min < 0 || d < min
          min = d
          s = c
        elsif min == d
          s = nil
        end
      end
      return s
    end
  end
  planets = Array(Coordinates).new
  x_max = 0
  y_max = 0
  i=0
  input.each do |coords|
    xs, ys = coords.split(",")
    x, y = xs.to_i, ys.to_i
    x_max = Math.max(x, x_max)
    y_max = Math.max(y, y_max)
    planets << Coordinates.new(x, y, i)
    i+=1
  end
  grid = Array(Coordinates).new
  puts x_max
  puts y_max
  (0..x_max).each do |x|
    (0..y_max).each do |y|
      here = Coordinates.new(x, y)
      grid << here
      planets.each do |p|
        dist = here.dist(p)
        here.distances[p] = dist
      end
    end
  end
  grid.each do |g|
    c = g.closest
    if c
      planets[c.name].area += 1
      if g.x == 0 || g.y == 0 || g.x == x_max || g.y == y_max
        planets[c.name].infinite = true
      end
    end
  end
  puts
  max = 0
  biggest = nil
  planets.each do |p|
    if p.area > max && !p.infinite
      biggest = p
      max = p.area
    end
  end
  if biggest
    puts "Biggest single area: #{biggest.x || "-"} #{biggest.y || "-"} #{biggest.area || "-"}"
  end
  a = 0
  grid.each do |g|
    if g.distances.values.reduce { |acc, i| acc + i } < 10000
      a+=1
    end
  end
  puts a
end
