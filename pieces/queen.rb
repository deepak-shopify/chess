require_relative 'direction'

class Queen < Piece
  UNICODE_BY_COLOR = {
    Piece::WHITE => '♕',
    Piece::BLACK => '♛',
  }

  INITIAL_POSITIONS_BY_COLOR = {
    Piece::WHITE => [
      InternalPosition.from_chess_pos('d', 1),
    ],
    Piece::BLACK => [
      InternalPosition.from_chess_pos('d', 8),
    ]
  }

  def get_unicode
    UNICODE_BY_COLOR[@color]
  end

  def valid_move?(move, piece_at_destination, is_path_blocked)
    if is_path_blocked
      return false
    end
    diagonal_move = move.row_change > 0 && move.col_change > 0 && move.row_change.abs == move.col_change.abs
    only_one_changed = move.row_change > 0 || move.col_change > 0
    diagonal_move || only_one_changed
  end

  def clear_paths(move)
    if move.row_change == move.col_change
      cols = (move.from.col + 1...move.to.col).each { |col| col }
      [Path.new((move.from.row + 1...move.to.row).each_with_index { |row, index| InternalPosition.new(row, cols[index]) })].drop(1)
    elsif move.row_change != 0
      [Path.new((move.from.row...move.to.row).each { |row| InternalPosition.new(row, move.from.col) })].drop(1)
    else
      [Path.new((move.from.col...move.to.col).each { |col| InternalPosition.new(move.from.row, col) })].drop(1)
    end
  end

  def self.get_initial_positions(color)
    INITIAL_POSITIONS_BY_COLOR[color]
  end
end
