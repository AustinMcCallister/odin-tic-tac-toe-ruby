# frozen_string_literal: true

module TicTacToe
  # Defines a game of Tic Tac Toe
  class Game
    attr_reader :player_one, :player_two
    attr_accessor :game_board, :current_player, :turn_count, :winner

    def initialize
      @game_board     = GameBoard.new
      @player_one     = Player.new('Player One', 'X')
      @player_two     = Player.new('Player Two', 'O')
      @current_player = player_one
      @turn_count     = 1
      @winner         = nil
      game_loop
    end

    private

    def game_loop
      while turn_count < 10 && !winner
        draw_game_board
        take_turn
        set_current_player
      end
      wrap_up
    end

    def draw_game_board
      DisplayController.clear_terminal
      DisplayController.draw_board(game_board.board_state)
      DisplayController.draw_scoreboard(player_one, player_two)
    end

    def take_turn
      print "\nEnter selection coordinates (eg. A1): "
      until (row, col = make_selection) && selection_taken?(row, col)
        print 'Invalid choice. Enter selection coordinates (eg. A1): '
      end
      update_cell(row, col)
      check_victory(row, col)
      self.turn_count += 1
    end

    def make_selection
      return unless (selection = gets.chomp).match?(/^[a-cA-C][1-3]$/)

      convert_coordinates(selection)
    end

    def convert_coordinates(selection)
      selection = selection.downcase.split('')
      [(selection.last.to_i - 1), (selection.first.ord - 97)]
    end

    def selection_taken?(row, col)
      game_board.cell_free?(row, col)
    end

    def update_cell(row, col)
      game_board.update_cell(row, col, current_player.symbol)
    end

    def check_victory(row, col)
      return unless game_board.victory?(row, col, current_player.symbol)

      self.winner = current_player
      current_player.score += 1
    end

    def set_current_player
      self.current_player = current_player.equal?(player_one) ? player_two : player_one
    end

    def wrap_up
      draw_game_board
      print "\nGame over! Would you like to play again? (y/N): "
      until (selection = gets.chomp) && selection.match?(/^[nyNY]?$/)
        print 'Invalid choice. Would you like to play again? (y/N): '
      end
      return unless selection.match?(/^[yY]$/)

      reset_board
      game_loop
    end

    def reset_board
      self.game_board     = GameBoard.new
      self.current_player = player_one
      self.winner         = nil
      self.turn_count     = 1
    end
  end
end
