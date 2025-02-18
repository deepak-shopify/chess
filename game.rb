# frozen_string_literal: true
require_relative 'board'
require_relative 'internal_position'
require_relative 'move'

def perform_move(board, input, color)
  if input.length != 5
    puts "Invalid input - Try again"
    return false
  end

  move = Move.new(
    InternalPosition.from_chess_pos(input[0], input[1].to_i),
    InternalPosition.from_chess_pos(input[3], input[4].to_i))
  unless board.move_piece?(move, color)
    puts "Try again!"
    return false
  end
  true
end

board = Board.new
i = 0
while true
  board.print_board
  color = ""
  if i % 2 == 0
    puts "White Plays"
    input = gets.chomp
    color = Piece::WHITE
    unless perform_move(board, input, color)
      next
    end
  else
    puts "Black Plays"
    input = gets.chomp
    color = Piece::BLACK
    unless perform_move(board, input, color)
      next
    end
  end

  if board.wins? color
    puts "#{color} WINS!!"
    break
  end

  if board.check_mate? color
    puts "#{color} WINS by CHECKMATE!!"
    break
  end
  i = i + 1
end
