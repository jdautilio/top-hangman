# frozen_string_literal: true

require_relative 'board'
require_relative 'game'
include Board # rubocop:disable Style/MixinUsage

dictionary = File.readlines('google-10000-english-no-swears.txt', chomp: true)
dictionary.filter { |w| w.length >= 5 && w.length <= 12 }.sample

game = Game.new('balas', 10)
render(game)

until game.ended?
  printf 'Your guess: '
  guess = $stdin.gets[0].downcase
  game.guess(guess)

  render(game)
end
