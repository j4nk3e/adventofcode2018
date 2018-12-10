# TODO: Write documentation for `Advent8`
module Advent8
  VERSION = "0.1.0"

  class Node
    property children = Array(Node).new
    property meta = Array(Int32).new

    def initialize(in : Array(Int32))
      ccount = in.delete_at(0)
      mcount = in.delete_at(0)
      ccount.times do
        children << Node.new(in)
      end
      mcount.times do
        meta << in.delete_at(0)
      end
    end

    def sum() : Int32
      if children.empty?
        return meta.sum
      end
      return meta.sum + children.sum { |c| c.sum() }
    end

    def value(): Int32
      if children.empty?
        return meta.sum
      end
      sum = 0
      meta.each do |m|
        if m <= children.size
          sum += children[m-1].value
        end
      end
      return sum
    end
  end

  input = File.read("input").split(" ").map { |n| n.to_i }
  n = Node.new(input)
  puts n.sum
  puts n.value
end
