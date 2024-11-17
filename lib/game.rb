# frozen_string_literal: true

class Game
  attr_reader :word, :guessed, :max_tries, :tries, :incorrect

  def initialize(word, max_tries)
    @word = word
    @max_tries = max_tries
    @tries = 0
    @guessed = [nil] * word.length
    @incorrect = []
  end

  def guess(guessed_char)
    return if @tries == @max_tries

    found = false
    @word.chars.each_with_index do |char, i|
      if char == guessed_char
        @guessed[i] = char
        found = true
      end
    end

    incorrect << guessed_char unless found
    @tries += 1
  end

  def ended?
    won? || remaining_tries.zero?
  end

  def won?
    !@guessed.include?(nil)
  end

  def remaining_tries
    @max_tries - @tries
  end
end
