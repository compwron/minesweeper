require_relative 'square'
class Board
  def initialize(coords, bomb_count)
    @x_size = coords.first
    @y_size = coords.last

    used_coords = []
    bomb_coords = (0...bomb_count).map do |_i|
      new_coord = _generate(@x_size, @y_size, used_coords)
      used_coords << new_coord
    end

    @data = (0...@x_size).map do |x|
      (0...@y_size).map do |y|
        Square.new([x, y], used_coords.include?([x, y]))
      end
    end.flatten

    @data.map do |c|
      c.adjacent_bombs(_bombs_next_to(c, @data))
    end
  end

  def _bombs_next_to(square, squares)
    squares.select do|s|
      ((s.x == square.x + 1) || (s.x == square.x - 1)) && (((s.y == square.y + 1) || (s.y == square.y - 1)) || (s.y == square.y)) ||
        ((s.y == square.y + 1) || (s.y == square.y - 1)) && (((s.x == square.x + 1) || (s.x == square.x - 1)) || (s.x == square.x))
    end.count(&:is_bomb?)
  end

  def _generate(x, y, used)
    generated = [rand(x), rand(y)]
    used.include?(generated) ? _generate(x, y, used) : generated
  end

  def to_s
    (0..@y_size).map do|y|
      @data.select { |s| s.y == y }.map(&:to_s).join(' ')
    end.join(" \n")
  end

  def reveal(x, y)
    square_at(x, y).reveal
  end

  def flag(x, y)
    square_at(x, y).flag
  end

  def square_at(x, y)
    @data.find { |s| s.x == x && s.y == y }
  end
end
