require_relative 'board'
class Game
  attr_reader :in_progress

  def initialize(board_size, bomb_count)
    @board = Board.new(board_size, bomb_count)
    @in_progress = true
  end

  def reveal(x, y)
    cell = @board.reveal(x, y)
    if cell.is_bomb?
      @in_progress = false
      @board.reveal_all
    elsif @board.full_and_accurate
      @in_progress = false
    end
  end

  def board
    @board.to_s
  end

  def flag(x, y)
    @board.flag(x, y)
    if @board.full_and_accurate
      @in_progress = false
   end
  end
end
