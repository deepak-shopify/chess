# frozen_string_literal: true

class Move
  attr_accessor :from, :to

  def initialize(from_position, to_position)
    @from = from_position
    @to = to_position
  end

  def row_change
    @to.row - @from.row
  end

  def col_change
    @to.col - @from.col
  end
end
