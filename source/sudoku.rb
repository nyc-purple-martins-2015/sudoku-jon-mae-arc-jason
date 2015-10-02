class Sudoku
  def initialize(board_string)
    @board_string = board_string
    @board = board
  end

  def game_over
  end

  def is_legal?(number, index)
  end

  def row_full?(array)
  end

  def row_has_num?(index)
  end

  def column_full?
    transposed_board = @board.transpose
    if transposed_board.any? { |element| element = "-" }
      false
    else
      true
    end
  end

  def column_has_num?(index)
  end

  def square_is_empty?(array)
  end

  def solve
  end

  def board
    @board = Array.new(9){@board_string.split("").shift(9)}
  end

  # Returns a string representing the current state of the board
  def to_s
    # @board.join("\n")
    # p @board
  end
end

