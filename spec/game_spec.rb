require_relative '../lib/game'
require 'rspec'

describe Game do
  let(:g) { Game.new([2, 2], 1) }
  let(:all_bombs_game) { Game.new([2, 2], 4) }

  it 'new game has unrevealed board' do
    expect(g.board).to eq("? ? \n? ? \n")
  end

  it 'shows whole board after loss' do
    _reveal_all(all_bombs_game)
    expect(all_bombs_game.board.chars.select { |i| i == 'B' }.size).to eq 4
  end

  it 'shows flag for suspected bomb on board' do
    g.flag(0, 0)
    expect(g.board).to eq("F ? \n? ? \n")
  end

  it 'reveals all squares when bomb is exploded' do
    all_bombs_game.reveal(0, 0)
    expect(all_bombs_game.board).to eq "B B \nB B \n"
  end

  describe '#in_progress' do
    it 'is in progress' do
      expect(g.in_progress).to eq true
    end

    it 'is not in progress after bomb is revealed' do
      all_bombs_game.reveal(0, 0)
      expect(all_bombs_game.in_progress).to eq false
    end

    it 'is not in progress if whole board has been flagged and is accurate' do
      _flag_all(all_bombs_game)
      expect(all_bombs_game.in_progress).to eq false
    end

    it 'is in progress if whole board has been flagged and is inaccurate' do
      _flag_all(g)
      expect(g.in_progress).to eq true
    end
  end

  def _reveal_all(game)
    game.reveal(0, 0)
    game.reveal(0, 1)
    game.reveal(1, 0)
    game.reveal(1, 1)
  end

  def _flag_all(game)
    game.flag(0, 0)
    game.flag(0, 1)
    game.flag(1, 0)
    game.flag(1, 1)
  end
end
