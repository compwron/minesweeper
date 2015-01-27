require_relative '../lib/board'
require 'rspec'

describe Board do
  it 'no bomb board revealed' do
    b = Board.new([2, 2], 0)
    _reveal_all(b)
    expect(b.to_s).to eq("0 0 \n0 0 \n")
  end

  it 'one bomb board revealed' do
    b = Board.new([2, 2], 1)
    _reveal_all(b)
    expect(b.to_s.chars.select { |c| c == '1' }.count).to eq 3
    expect(b.to_s.chars.select { |c| c == 'B' }.count).to eq 1
  end

  it 'all bomb board revealed' do
    b = Board.new([2, 2], 4)
    _reveal_all(b)
    expect(b.to_s).to eq("B B \nB B \n")
  end

  it 'zero bomb board partially revealed' do
    b = Board.new([2, 2], 0)
    b.reveal(0, 0)
    expect(b.to_s).to eq("0 ? \n? ? \n")
  end

  it 'flags suspected bomb' do
    b = Board.new([2, 2], 0)
    b.flag(0, 0)
    expect(b.to_s).to eq("F ? \n? ? \n")
  end

  it 'flagged square can be revealed' do
    b = Board.new([2, 2], 4)
    b.flag(0, 0)
    b.reveal(0, 0)
    expect(b.to_s).to eq("B ? \n? ? \n") # actually revealing a bomb loses the game TODO
  end

  def _reveal_all(board)
    (0...2).each do|i|
      (0...2).each do|j|
        board.reveal(i, j)
      end
    end
  end
end
