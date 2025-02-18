require_relative 'direction'

class Piece
  WHITE = "white"
  BLACK = "black"

  attr_accessor :color

  def initialize(color)
    @color = color
  end

  def get_unicode
    fail NotImplementedError, "Unicode letter not implemented!"
  end

  def clear_paths(move)
    fail NotImplementedError, "Unicode letter not implemented!"
  end

  def valid_move?(move, piece_at_destination, is_path_blocked)
    fail NotImplementedError, "Unicode letter not implemented!"
  end
end
