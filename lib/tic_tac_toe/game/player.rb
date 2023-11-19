# frozen_string_literal: true

module TicTacToe
  class Game
    # Defines a player
    class Player
      attr_reader :name, :symbol
      attr_accessor :score

      def initialize(name, symbol)
        @name   = name
        @symbol = symbol
        @score  = 0
      end
    end
  end
end
