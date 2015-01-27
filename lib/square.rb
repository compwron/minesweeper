class Square
  attr_reader :x, :y, :adjacent_bomb_count
  def initialize(coords, is_bomb)
    @x = coords.first
    @y = coords.last
    @is_bomb = is_bomb
    @adjacent_bomb_count = 0
    @revealed = false
    @is_flag = false
  end

  def is_bomb?
    @is_bomb
  end

  def adjacent_bombs(count)
    @adjacent_bomb_count = count
  end

  def reveal
    @revealed = true
  end

  def flag
    @is_flag = true
  end

  def to_s
    if @revealed
      return 'B' if is_bomb?
      return "#{@adjacent_bomb_count}"
    end
    return 'F' if @is_flag

    '?'
  end
end
