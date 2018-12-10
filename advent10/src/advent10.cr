# TODO: Write documentation for `Advent10`
module Advent10
  extend self
  VERSION = "0.1.0"
  input = File.read_lines("input")

  class Point
    property x, y
    property v_x, v_y

    def initialize(@x : Int64, @y : Int64, @v_x : Int64, @v_y : Int64)
    end

    def move
      @x += @v_x
      @y += @v_y
    end

    def clone
      return Point.new @x, @y, @v_x, @v_y
    end
  end

  points = Array(Point).new
  input.each do |p|
    coords = /position\=<\s*([\-0-9]+),\s*([\-0-9]+)>\s+velocity\=<\s*([\-0-9]+),\s*([\-0-9]+)>/.match(p)
    if coords
      x = coords[1].to_i64
      y = coords[2].to_i64
      v_x = coords[3].to_i64
      v_y = coords[4].to_i64
      points << Point.new x, y, v_x, v_y
    else
      puts "error: #{p}"
    end
  end

  def area(points : Array(Point))
    x_min = points.min_by { |p| p.x }.x
    x_max = points.max_by { |p| p.x }.x
    y_min = points.min_by { |p| p.y }.y
    y_max = points.max_by { |p| p.y }.y
    return (x_max - x_min) * (y_max - y_min)
  end

  def print(points : Array(Point))
    x_min = points.min_by { |p| p.x }.x
    x_max = points.max_by { |p| p.x }.x+15
    y_min = points.min_by { |p| p.y }.y
    y_max = points.max_by { |p| p.y }.y
    a = area(points)
    len = x_max - x_min
    code = Array(Char).new a*2, do ' ' end
    points.each do |p|
      col = p.x - x_min
      row = p.y - y_min
      code[col+row*len] = '#'
    end
    (y_max - y_min + 1).times do |i|
      puts "#{i} #{code[(len*i)..(len*(i + 1))].join("")}"
    end
  end

  generation = 0
  while true
    a = area(points)
    if a < 10000
      print points
      puts generation
    end
    points.each do |p|
      p.move
    end
    generation += 1
    b = area(points)
    if b > a
      break
    end
  end
end
