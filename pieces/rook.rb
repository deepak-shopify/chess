require_relative 'direction'

class Rook < Piece
  UNICODE_BY_COLOR = {
    Piece::WHITE => '♖',
    Piece::BLACK => '♜',
  }

  INITIAL_POSITIONS_BY_COLOR = {
    Piece::WHITE => [
      InternalPosition.from_chess_pos('a', 1),
      InternalPosition.from_chess_pos('h', 1),
    ],
    Piece::BLACK => [
      InternalPosition.from_chess_pos('a', 8),
      InternalPosition.from_chess_pos('h', 8),
    ]
  }

  def get_unicode
    UNICODE_BY_COLOR[@color]
  end

  def valid_move?(move, piece_at_destination, is_path_blocked)
    if is_path_blocked
      return false
    end

    both_changed = move.row_change > 0 && move.col_change > 0
    only_one_changed = move.row_change > 0 || move.col_change > 0
    !both_changed && only_one_changed
  end

  def clear_paths(move)
    if move.row_change != 0
      [Path.new((move.from.row...move.to.row).each { |row| InternalPosition.new(row, move.from.col) })].drop(1)
    else
      [Path.new((move.from.col...move.to.col).each { |col| InternalPosition.new(move.from.row, col) })].drop(1)
    end
  end

  def self.get_initial_positions(color)
    INITIAL_POSITIONS_BY_COLOR[color]
  end
end
