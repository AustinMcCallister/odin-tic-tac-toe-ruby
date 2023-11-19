# frozen_string_literal: true

module TicTacToe
  class Game
    class GameBoard
      # Defines an individual cell on the game board
      class Cell
        attr_accessor :symbol

        def initialize
          @symbol = nil
        end

        def free?
          symbol.nil?
        end

        def to_s
          symbol || ' '
        end
      end
    end
  end
end
