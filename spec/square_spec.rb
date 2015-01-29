require_relative '../lib/square'
require 'rspec'

describe Square do
  let(:s) { Square.new([5, 1], false) }
  let(:bomb) { Square.new([5, 1], true) }

  describe 'reveal' do
    it 'returns self' do
      expect(s.reveal.is_bomb?).to eq false
      expect(s.reveal.to_s).to eq '0'
    end
  end

  it 'accepts adjacent bombs count' do
    s.adjacent_bombs(2)
    s.reveal

    expect(s.x).to eq 5
    expect(s.y).to eq 1
    expect(s.to_s).to eq '2'
    expect(s.is_bomb?).to eq false
  end

  it 'can be a non bomb' do
    expect(s.is_bomb?).to eq false
  end

  it 'is not revealed by default' do
    expect(s.to_s).to eq '?'
  end

  it 'is not revealed by default if bomb' do
    expect(bomb.to_s).to eq '?'
  end

  it 'shows exploded bomb when revealed' do
    bomb.reveal
    expect(bomb.to_s).to eq 'B'
  end

  it 'shows adjacent bomb count when revealed' do
    s.adjacent_bombs(2)
    s.reveal
    expect(s.to_s).to eq '2'
  end

  it 'flags square as suspected bomb' do
    s.flag
    expect(s.to_s).to eq 'F'
  end
end
