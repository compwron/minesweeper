class Board
	def initialize board_size, bomb_count
		x = board_size.first
		y = board_size.last

		used_coords = []
		bomb_coords = (0...bomb_count).map { |i|
			new_coord = generate(x, y, used_coords)
			used_coords << new_coord
		}

		p bomb_coords

		@data = (0...board_size.first).map { |x|
			(0...board_size.last).map { |y|
				if used_coords.include?([x, y])
					Square.new([x, y], true)
				else
					Square.new([x, y], false)
				end
			}
		}

		@data.flatten.map { |c|
			c.adjacent_bombs(bombs_next_to(c, @data))
		}

		# everything is masked
	end

	def bombs_next_to square, squares
		squares.select {|s|
			# x +- 1 and (y += 1 || y ==)
			# y +- 1 and (x +=1 || x ==)
			# [:+, :-].map {}
			((s.x == square.x + 1) || (s.x == square.x - 1)) && (((s.y == square.y + 1) || (s.y == square.y - 1)) || (s.y == square.y)) #||
				# ((s.x == square.x + 1) || (s.x == square.x - 1)) && (((s.y == square.y + 1) || (s.y == square.y - 1)) || (s.y == square.y)) 

		}.count(&:is_bomb?)
	end

	def generate x, y, used
		generated = [rand(x), rand(y)]
		if !used.include? generated
			generated
		else
			generate x, y, used
		end
		
	end

	def reveal x, y
		square_at([x, y]).reveal
	end

	def data
		@data
	end
end