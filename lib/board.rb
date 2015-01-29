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

  def full_and_accurate
    _full && _accurate
  end

  def _full
    @data.select { |s| s.to_s == '?' }.count == 0
  end

  def _accurate
    @data.select { |s| s.to_s == 'F' }.reject(&:is_bomb?).count == 0
  end

  def reveal_all
    (0...@x_size).each do|i|
      (0...@y_size).each do|j|
        reveal(i, j)
      end
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
    # if revealed square is a bomb, mark it X and reveal all others without marking them.
  end

  def flag(x, y)
    square_at(x, y).flag
  end

  def square_at(x, y)
    @data.find { |s| s.x == x && s.y == y }
  end
end
