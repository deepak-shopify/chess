require_relative 'direction'

class Bishop < Piece

  UNICODE_BY_COLOR = {
    Piece::WHITE => '♗',
    Piece::BLACK => '♝',
  }

  INITIAL_POSITIONS_BY_COLOR = {
    Piece::WHITE => [
      InternalPosition.from_chess_pos('c', 1),
      InternalPosition.from_chess_pos('f', 1),
    ],
    Piece::BLACK => [
      InternalPosition.from_chess_pos('c', 8),
      InternalPosition.from_chess_pos('f', 8),
    ]
  }

  def get_unicode
    UNICODE_BY_COLOR[@color]
  end

  def valid_move?(move, piece_at_destination, is_path_blocked)
    if is_path_blocked
      return false
    end
    move.row_change > 0 && move.col_change > 0 && move.row_change.abs == move.col_change.abs
  end

  def clear_paths(move)
    cols = (move.from.col...move.to.col).each { |col| col }
    [Path.new((move.from.row...move.to.row).each_with_index { |row, index| InternalPosition.new(row, cols[index]) })].drop(1)
  end

  def self.get_initial_positions(color)
    INITIAL_POSITIONS_BY_COLOR[color]
  end

end