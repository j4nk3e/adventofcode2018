# TODO: Write documentation for `Advent13`
module Advent13
  extend self

  class Cart
    property direction : Char
    @turn = 0

    def initialize(@direction : Char)
    end

    def turn_cw
      @direction = case @direction
                   when '>'
                     'v'
                   when 'v'
                     '<'
                   when '<'
                     '^'
                   else
                     '>'
                   end
    end

    def turn_ccw
      3.times do
        turn_cw
      end
    end

    def turn
      ((3 + @turn) % 4).times do
        turn_cw
      end
      @turn = (@turn + 1) % 3
    end

    def rail(type : Char)
      case type
      when '+'
        turn
      when '/'
        @direction == '>' || @direction == '<' ? turn_ccw : turn_cw
      when '\\'
        @direction == 'v' || @direction == '^' ? turn_ccw : turn_cw
      end
    end
  end

  class Tile
    property cart : Cart?
    property nextCart : Cart?
    property x : Int32
    property y : Int32
    property type : Char

    def initialize(@x : Int32, @y : Int32, @type : Char)
    end
  end

  carts = Array(Cart)
  input = File.read_lines("input")
  map = Array(Array(Tile)).new input.size
  input.each_with_index do |line, y|
    map << Array(Tile).new line.size
    line.each_char_with_index do |c, x|
      if c == '<' || c == '>'
        tile = Tile.new x, y, '-'
        tile.cart = Cart.new c
        map[y] << tile
      elsif c == 'v' || c == '^'
        tile = Tile.new x, y, '|'
        tile.cart = Cart.new c
        map[y] << tile
      else
        tile = Tile.new x, y, c
        map[y] << tile
      end
    end
  end

  gen = 0
  crash = 0
  while crash == 0
    map.each_with_index do |line, y|
      line.each_with_index do |tile, x|
        c = tile.cart
        if c
          target = case c.direction
                   when '<'
                     line[x - 1]
                   when '>'
                     line[x + 1]
                   when '^'
                     map[y - 1][x]
                   else
                     map[y + 1][x]
                   end
          if target.cart || target.nextCart
            puts "#{target.x}, #{target.y}"
            target.cart = nil
            target.nextCart = nil
          else
            c.rail target.type
            target.nextCart = c
            tile.cart = nil
          end
        end
      end
    end
    puts gen += 1
    carts = 0
    last_cart = nil
    map.each_with_index do |line, y|
      line.each_with_index do |tile, x|
        tile.cart = tile.nextCart
        tile.nextCart = nil
        if tile.cart
          last_cart = tile
          carts+=1
        end
      end
      # puts line.map { |t| t.cart.try &.direction || t.type }.join
    end
    if carts == 1 && last_cart
      puts "#{last_cart.x}, #{last_cart.y}"
      break
    end
  end
end
