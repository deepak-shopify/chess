class InternalPosition
  attr_accessor :col, :row

  def initialize(row, col)
    @row = row
    @col = col
  end

  def self.to_chess_row(row)
    8 - row
  end

  def self.to_chess_col(col)
    (col + 'a'.ord).chr
  end

  # This is the position from a chess perspective
  # rows go from 8-1 and cols go from a-h
  def self.from_chess_pos(col, row)
    InternalPosition.new(8 - row, col.ord - 'a'.ord)
  end
end
