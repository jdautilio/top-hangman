# frozen_string_literal: true

module Board
  def render(game)
    str = game.guessed.map { |c| c.nil? ? '_' : c }.join(' ')
    str += ' | '
    str +=
      if game.ended?
        game.won? ? 'You win!' : "Out of tries. The word was '#{game.word}'."
      else
        "remaining tries: #{game.remaining_tries} | [#{game.incorrect.join(' ')}]"
      end

    puts str
  end
end
