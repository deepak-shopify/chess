require_relative 'pieces/piece'
require_relative 'pieces/king'
require_relative 'pieces/queen'
require_relative 'pieces/bishop'
require_relative 'pieces/knight'
require_relative 'pieces/rook'
require_relative 'pieces/pawn'

class Board

  BLANK_CELL = '-'
  DELIMITER = ' '
  HEADER = ('a'..'h')

  attr_accessor :grid, :captured_pieces

  def initialize
    @grid = Array.new(8) { |ignored| Array.new(8) }
    @captured_pieces = {
      Piece::WHITE => [],
      Piece::BLACK => []
    }
    initialize_pieces
  end

  def move_piece?(move, color)
    from_piece = @grid[move.from.row][move.from.col]
    if from_piece.nil?
      puts "The piece does not exist"
      return false
    elsif color != from_piece.color
      puts "The is not your piece"
      return false
    end
    to_piece = @grid[move.to.row][move.to.col]
    piece_at_destination = to_piece != nil
    # TODO: Support castling
    # TODO: Support moving pawn by 2 moves in the first step
    if piece_at_destination && from_piece.color == to_piece.color
      puts "Piece of same color exists in the destination"
      return false
    end
    clear_path = from_piece.clear_paths move
    is_path_blocked = clear_path.any? { |path| path.any? { |position| @grid[position.row][position.col] != nil } }
    is_valid_move = from_piece.valid_move? move, piece_at_destination, is_path_blocked
    if is_valid_move
      puts "Move does not follow the rules for the piece"
      return false
    end

    @grid[move.to.row][move.to.col] = from_piece
    @grid[move.from.row][move.from.col] = nil
    true
  end

  def print_board
    print_row HEADER, DELIMITER
    @grid.each_with_index do |row, row_index|
      print_row row, InternalPosition.to_chess_row(row_index).to_s
    end
  end

  def check_mate?(color)

  end

  def wins?(color)
    captured_color = color == Piece::WHITE ? Piece::BLACK : Piece::WHITE
    @captured_pieces[captured_color].any? do |captured_piece|
      captured_piece is_a? King
    end
  end

  private

  def initialize_pieces
    initialize_pieces_for_color(Piece::WHITE)
    initialize_pieces_for_color(Piece::BLACK)
  end

  def initialize_pieces_for_color(color)
    set_at_position = lambda { |position, piece| @grid[position.row][position.col] = piece }

    King.get_initial_positions(color).each { |position| set_at_position.call position, King.new(color) }
    Queen.get_initial_positions(color).each { |position| set_at_position.call position, Queen.new(color) }
    Bishop.get_initial_positions(color).each { |position| set_at_position.call position, Bishop.new(color) }
    Knight.get_initial_positions(color).each { |position| set_at_position.call position, Knight.new(color) }
    Rook.get_initial_positions(color).each { |position| set_at_position.call position, Rook.new(color) }
    Pawn.get_initial_positions(color).each { |position| set_at_position.call position, Pawn.new(color) }
  end

  def print_row(row, prefix)
    strings = row.map do |item|
      case item
      when Piece then item.get_unicode
      when String then item
      else BLANK_CELL
      end
    end
    puts prefix + DELIMITER + strings.join(DELIMITER)
  end
end
