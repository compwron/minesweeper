require_relative 'board'
class Game
  def initialize(board_size, bomb_count)
    @board = Board.new(board_size, bomb_count)
  end

  def reveal(x, y)
    @board.reveal(x, y)
  end

  def board
    @board.to_s
  end

  def flag(x, y)
    @board.flag(x, y)
  end
end
