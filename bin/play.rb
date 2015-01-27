require_relative '../lib/game'
g = Game.new([2, 2], 1) # board size x. y, bombcount
g.reveal(0, 1)
# ? 1
# ? ?

g.flag(0, 0)
# F 1
# ? ?

puts g.board # should be

# B 1
# 1 1

# routes
# /game/1
# /game/1/board
# /game/1/flag [0, 9]
# /game/1/reveal [0, 9]
