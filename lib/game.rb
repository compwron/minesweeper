require_relative 'board'
class Game
	def initialize(board_size, bomb_count)
		@board = Board.new(board_size, bomb_count)
	end

	def reveal x, y
		@board.reveal x, y
	end

	def board
		@board.data
	end
end