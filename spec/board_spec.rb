require_relative '../lib/board'
require 'rspec'

describe Board do
  let(:b) { Board.new([2, 2], 0) }
  let(:all_bombs) { Board.new([2, 2], 4) }
  let(:one_bomb) { Board.new([2, 2], 1) }

  describe 'full_and_accurate' do
    it 'can be full but inaccurate' do
      b.flag(0, 0)
      b.reveal(0, 1)
      b.reveal(1, 1)
      b.reveal(1, 0)

      expect(b.to_s).to eq "F 0 \n0 0 \n"
      expect(b.full_and_accurate).to eq false
    end

    it 'not full and also inaccurate' do
      b.flag(0, 0)
      expect(b.full_and_accurate).to eq false
    end

    it 'without bombs' do
      _reveal_all(b)
      expect(b.full_and_accurate).to eq true
    end

    it 'with bombs' do
      _flag_all(all_bombs)
      expect(all_bombs.full_and_accurate).to eq true
    end
  end
  describe 'reveal_all' do
    it 'reveals all on all bomb board' do
      all_bombs.reveal_all
      expect(all_bombs.to_s).to eq "B B \nB B \n"
    end

    it 'reveals all empty squares also' do
      b.reveal_all
      expect(b.to_s).to eq "0 0 \n0 0 \n"
    end
  end

  describe 'reveal' do
    it 'returns cell' do
      cell = b.reveal(0, 0)
      expect(cell.to_s).to eq '0'
    end

    it 'shows exploded bomb' do
      cell = all_bombs.reveal(0, 0)
      expect(cell.to_s).to eq 'B'
    end
  end

  it 'no bomb board revealed' do
    _reveal_all(b)
    expect(b.to_s).to eq("0 0 \n0 0 \n")
  end

  it 'one bomb board revealed' do
    _reveal_all(one_bomb)
    expect(one_bomb.to_s.chars.select { |c| c == '1' }.count).to eq 3
    expect(one_bomb.to_s.chars.select { |c| c == 'B' }.count).to eq 1
  end

  it 'all bomb board revealed' do
    _reveal_all(all_bombs)
    expect(all_bombs.to_s).to eq("B B \nB B \n")
  end

  it 'zero bomb board partially revealed' do
    b.reveal(0, 0)
    expect(b.to_s).to eq("0 ? \n? ? \n")
  end

  it 'flags suspected bomb' do
    b.flag(0, 0)
    expect(b.to_s).to eq("F ? \n? ? \n")
  end

  it 'flagged square can be revealed' do
    flagged_cell = all_bombs.flag(0, 0)
    expect(flagged_cell.to_s).to eq 'F'

    revealed_cell = all_bombs.reveal(0, 0)
    expect(revealed_cell.to_s).to eq 'B'
  end

  def _reveal_all(board)
    (0...2).each do|i|
      (0...2).each do|j|
        board.reveal(i, j)
      end
    end
  end

  def _flag_all(board)
    (0...2).each do|i|
      (0...2).each do|j|
        board.flag(i, j)
      end
    end
  end
end
