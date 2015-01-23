require_relative '../lib/game'
require 'rspec'

describe Game do 
	it "new game has unrevealed board" do
		g = Game.new([2, 2], 1)
		expect(g.board).to eq([['?', '?'], ['?', '?']])
	end

	it "shows whole board after loss" do
		g = Game.new([2, 2], 1)
		g.reveal(0, 0)
		g.reveal(0, 1)
		g.reveal(1, 0)
		g.reveal(1, 1)
		expect(g.board.flatten.select {|i| i == 'B'}.size).to eq 1 
		expect(g.board.flatten.select {|i| i == '1'}.size).to eq 3 
	end
end

