class Sudoku
  attr_reader :board, :boxes
  def initialize(board_string)
    @board_string = board_string
    @board = board
    @boxes = compile_all_boxes
  end

  def game_over
  end

  def is_legal?(number, index)
  end

  def row_full?(array)
  end

  def in_row?(index)
  end

  def column_full?(col_index)
    @board.each{|row| return false if @board[row][col_index]=="-"}
    true
  end

  def in_col?(index)
  end

  def box_full?(box)
    return false if box.any?{|e| e == empty }
    true
  end

  def in_box?(box, num)
    @boxes[box].include?(num)
  end

  #input:  coordinates on the grid
  #output: 3x3 box (as a string) that includes the square at those coordinates

  def which_box(row, col)
    if (0..2).include?(row) && (0..2).include?(col)
      return "box_1"
    elsif (0..2).include?(row) && (3..5).include?(col)
      return "box_2"
    elsif (0..2).include?(row) && (6..8).include?(col)
      return "box_3"
    elsif (3..5).include?(row) && (0..2).include?(col)
      return "box_4"
    elsif (3..5).include?(row) && (3..5).include?(col)
      return "box_5"
    elsif (3..5).include?(row) && (6..8).include?(col)
      return "box_6"
    elsif (6..8).include?(row) && (0..2).include?(col)
      return "box_7"
    elsif (6..8).include?(row) && (3..5).include?(col)
      return "box_8"
    elsif (6..8).include?(row) && (6..8).include?(col)
      return "box_9"
    else
      p "illegal index"
    end
  end


  def square_is_empty?(row_index, col_index)
    return false if board[row_index][col_index] != "-"
    true
  end

  def solve
  end

  def board
    board_array = @board_string.split("")
    @board = Array.new(9){board_array.shift(9)}
  end

# compiles all boxes (1-9) into a hash with 1-d arrays as values
  def compile_all_boxes
    boxes={}
    row=0
    col=0
    i=1
    while row<8
      while col<8
        boxes["box_#{i}"] = compile_box(row, col)
        i+=1
        col+=3
      end
    col=0
    # i+=1
    row+=3
    end

    boxes
  end

  # compile a single box

  def compile_box(start_row, start_col)
    box=[]
    for row in start_row..(start_row+2)
      for col in start_col..(start_col+2)
        box << @board[row][col]
      end
    end
    box
  end




  def compile_row(string, length)
    string.split("")
  end

  # Returns a string representing the current state of the board
  def to_s
    # @board_string.join("\n")
  end

end


