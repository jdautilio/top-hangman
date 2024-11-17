# frozen_string_literal: true

require_relative 'board'
require_relative 'game'
include Board # rubocop:disable Style/MixinUsage

def save(game, filename)
  serialized_game = Marshal.dump(game)
  Dir.mkdir('saves') unless Dir.exist? 'saves'

  File.open(File.join('saves', filename), 'w') do |file|
    file.write serialized_game
  end
end

def load(filename)
  Marshal.load File.read(File.join('saves', filename)) # rubocop:disable Security/MarshalLoad
end

dictionary = File.readlines('google-10000-english-no-swears.txt', chomp: true)
word = dictionary.filter { |w| w.length >= 5 && w.length <= 12 }.sample

puts 'Load game? [y/N]'
should_load = gets[0].downcase == 'y'

game =
  if should_load
    load('game')
  else
    Game.new(word, 10)
  end

render(game)
until game.ended?
  printf 'Your guess: '
  guess = $stdin.gets[0].downcase
  game.guess(guess)

  render(game)

  puts 'Save? [Y,n]'
  save = gets[0].downcase != 'n'

  save(game, 'game') if save
end
