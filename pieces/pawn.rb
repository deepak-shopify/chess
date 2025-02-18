require_relative 'direction'

class Pawn < Piece

  UNICODE_BY_COLOR = {
    Piece::WHITE => '♙',
    Piece::BLACK => '♟',
  }

  INITIAL_POSITIONS_BY_COLOR = {
    Piece::WHITE => ('a'..'h').map { |char| InternalPosition.from_chess_pos(char, 2) },
    Piece::BLACK => ('a'..'h').map { |char| InternalPosition.from_chess_pos(char, 7) }
  }

  def get_unicode
    UNICODE_BY_COLOR[@color]
  end

  def valid_move?(move, piece_at_destination, is_path_blocked)
    diagonal_move = move.row_change.abs == 1 && move.row_change.abs == move.col_change.abs
    moved_forward = (@color == Piece::WHITE ? move.col_change < 0 : move.col_change > 0) && move.row_change.abs == 1

    if moved_forward && piece_at_destination
      puts "Forward Move - Piece at destination"
      return false
    end

    if diagonal_move && !piece_at_destination
      puts "Diagonal Move - No Piece at destination"
      return false
    end

    diagonal_move || moved_forward
  end

  def clear_paths(move)
    []
  end

  def self.get_initial_positions(color)
    INITIAL_POSITIONS_BY_COLOR[color]
  end
end
