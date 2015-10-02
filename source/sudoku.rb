require 'pry'

class Sudoku
  def initialize(board_string)
    @board_string = board_string
    @board = board
  end

  def game_over
    # so far, this method checks if the entire board is full.
    @board.each do |column|
      column.each do |value|
        if value == "-"
          p false
        else
          p true
        end
      end
    end
  end

  def is_legal?(number, index)
  end

  def row_full?
    i = 0
    for i in @board
      if i.include?("-")
        false
      else
        true
      end
    end
  end

  def row_has_num?(index)
  end

  def column_full?
    transposed = @board.transpose
    i = 0
    for i in transposed
      if i.include?("-")
        false
      else
        true
      end
    end
  end

  def column_has_num?(index)
  end

  def square_is_empty?(array)
  end

  def solve
  end

  def board
    board_array = @board_string.split("")
    @board = Array.new(9){board_array.shift(9)}
  end

  # Returns a string representing the current state of the board
  def to_s
    # @board.join("\n")
    # p @board
  end
end

