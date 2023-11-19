# frozen_string_literal: true

module TicTacToe
  # Controls the display of the game elements
  module DisplayController
    def self.draw_board(board_state)
      puts 'A   B   C'.rjust(16)
      board_state.each.with_index do |row, index|
        puts "#{index + 1} #{row.join(' │ ')}".rjust(16)
        puts '───┼───┼───'.rjust(17) unless index == (board_state.size - 1)
      end
    end

    def self.draw_scoreboard(player_one, player_two)
      puts "\n#{player_one.name} | #{player_two.name}"
      puts player_one.score.to_s.rjust(6) + player_two.score.to_s.rjust(13)
    end

    def self.clear_terminal
      system('clear') || system('cls')
    end
  end
end
