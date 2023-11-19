# frozen_string_literal: true

module TicTacToe
  class Game
    # Defines the game board
    class GameBoard
      attr_reader :board_state

      def initialize
        @board_state = Array.new(3) { Array.new(3) { Cell.new } }
      end

      def cell_free?(row, col)
        board_state[row][col].free?
      end

      def update_cell(row, col, symbol)
        board_state[row][col].symbol = symbol
      end

      def victory?(row, col, symbol)
        vertical?(col, symbol) || horizontal?(row, symbol) || diagonal_down?(symbol) || diagonal_up?(symbol)
      end

      private

      def vertical?(col, symbol)
        board_state.transpose[col].all? { |cell| cell.symbol == symbol }
      end

      def horizontal?(row, symbol)
        board_state[row].all? { |cell| cell.symbol == symbol }
      end

      def diagonal_down?(symbol)
        Matrix.rows(board_state).each(:diagonal).to_a.all? { |cell| cell.symbol == symbol }
      end

      def diagonal_up?(symbol)
        Matrix.rows(board_state).rotate_entries.each(:diagonal).to_a.all? { |cell| cell.symbol == symbol }
      end
    end
  end
end
