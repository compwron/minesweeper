#!/usr/bin/ruby

require_relative '../lib/game'
if ARGV.size != 3
  puts 'Usage: play.rb <x size> <y size> <bomb count>'
  exit
end

max_x = ARGV[0].to_i
max_y = ARGV[1].to_i
bomb_count = ARGV[2].to_i

g = Game.new([max_x, max_y], bomb_count)
while g.in_progress
  puts g.board
  puts "Options: \n  reveal <x> <y>\n  flag <x> <y>"
  user_says = STDIN.gets.chomp
  pieces = user_says.split(' ')
  if pieces.first == 'reveal'
    g.reveal(pieces[1].to_i, pieces[2].to_i)
  elsif pieces.first == 'flag'
    g.flag(pieces[1].to_i, pieces[2].to_i)
  else
    puts 'invalid command'
  end
end
puts 'Game over'
puts g.board
