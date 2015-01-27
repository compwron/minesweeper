require_relative '../lib/square'
require 'rspec'

describe Square do
  it 'accepts adjacent bombs count' do
    s = Square.new([5, 1], false)
    s.adjacent_bombs(2)
    s.reveal

    expect(s.x).to eq 5
    expect(s.y).to eq 1
    expect(s.to_s).to eq '2'
    expect(s.is_bomb?).to eq false
  end

  it 'can be a non bomb' do
    s = Square.new([5, 1], false)
    expect(s.is_bomb?).to eq false
  end

  it 'is not revealed by default' do
    s = Square.new([5, 1], false)
    expect(s.to_s).to eq '?'
  end

  it 'is not revealed by default if bomb' do
    s = Square.new([5, 1], true)
    expect(s.to_s).to eq '?'
  end

  it 'shows bomb when revealed' do
    s = Square.new([5, 1], true)
    s.reveal
    expect(s.to_s).to eq 'B'
  end

  it 'shows adjacent bomb count when revealed' do
    s = Square.new([5, 1], false)
    s.adjacent_bombs(2)
    s.reveal
    expect(s.to_s).to eq '2'
  end

  it 'flags square as suspected bomb' do
    s = Square.new([5, 1], false)
    s.flag
    expect(s.to_s).to eq 'F'
  end
end
