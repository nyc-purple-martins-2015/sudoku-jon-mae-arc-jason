require 'pry'

class Sudoku
  def initialize(board_string)
    @board_string = board_string
    @board = board
  end

  def game_over
    # so far, this method checks if the entire board is full.
    row = 0
    for row in @board
      if row.include?("-")
        false
      else
        true
      end
    end
    # @board.each do |column|
    #   column.each do |value|
    #     if value == "-"
    #       false
    #     else
    #       true
    #     end
    #   end
    # end
  end

  def is_legal?(number, index)
    # call number in a row, call number in a column

  end


  def in_row?(row, num)
    row.include?(num)
  end

  # def column_full?
  #   transposed = @board.transpose
  #   i = 0
  #   for i in transposed
  #     if i.include?("-")
  #       false
  #     else
  #       true
  #     end
  #   end
  # end

  def in_column?(col_ind, num)
    # col.include?(num)
    @board.each{|row| return true if @board[row][col_ind].eql?(num)}
    false
  end

  def square_is_empty?(array)
  end

  def solve
    #iterate through each space in the array
    # insert 1 into that space.
    # is_legal?
    # if true, leave it
    # elsif false, add 1 to that number, input 2
    # is_legal?
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

#comments and stuff
