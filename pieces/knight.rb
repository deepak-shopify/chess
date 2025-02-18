require_relative 'direction'

class Knight < Piece

  UNICODE_BY_COLOR = {
    Piece::WHITE => '♘',
    Piece::BLACK => '♞',
  }

  INITIAL_POSITIONS_BY_COLOR = {
    Piece::WHITE => [
      InternalPosition.from_chess_pos('b', 1),
      InternalPosition.from_chess_pos('g', 1),
    ],
    Piece::BLACK => [
      InternalPosition.from_chess_pos('b', 8),
      InternalPosition.from_chess_pos('g', 8),
    ]
  }

  def get_unicode
    UNICODE_BY_COLOR[@color]
  end

  def valid_move?(move, piece_at_destination, is_path_blocked)
    horizontal_move = move.row_change.abs == 2 && move.col_change.abs == 1
    vertical_move = move.row_change.abs == 1 && move.col_change.abs == 2
    horizontal_move || vertical_move
  end

  def clear_paths(move)
    []
  end

  def self.get_initial_positions(color)
    INITIAL_POSITIONS_BY_COLOR[color]
  end
end
