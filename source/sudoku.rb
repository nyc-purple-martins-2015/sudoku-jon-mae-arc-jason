

class Sudoku
  attr_reader :board, :boxes, :starting_numbers
  def initialize(board_string)
    @board_string = board_string
    @board = board
    @boxes = compile_all_boxes
    @starting_numbers=[]
    create_starting_numbers
  end

  def create_starting_numbers

    @board.each_index do |row|
      @board.each_index do |col|
        starting_numbers << [row.to_s, col.to_s] if @board[row][col]!="-"
      end
    end
  end

    #iterate through each space in the array
    # insert 1 into that space.
    # is_legal?
    # if true, leave it
    # elsif false, add 1 to that number, input 2
    # is_legal?
  def solve(row=0, col=0, num=1)
    return true if game_over?
    if !square_is_empty?(row, col)
      row +=1 if col == 8
      col+=1
      col%=9
      solve(row, col, 1)
    else
      if is_legal?(num, row, col) && num <= 9
        @board[row.to_s][col.to_s]=num
        row +=1 if col == 8
        col+=1
        col%=9
        solve(row, col, num)
      elsif num > 9
         row -=1 if col == 0
          col-=1
          col%=9
        solve(row, col, num)
      else
        num+=1
        solve(row, col, num)
      end
    end
  end

  def game_over?
    for row in @board
      if row.include?("-")
        return false
      else
        true
      end
    end
  end

  def is_legal?(num, row, col)
    raise RuntimeError.new("you passed in a row of value #{row} and a column of value #{col}") if row>8 || col>8
    return false if in_row?(board[row], num) || in_col?(col, num) || in_box?(@boxes[which_box(row, col)], num)
    true
  end

  def in_row?(row, num)
    row.include?(num)
  end

  def in_column?(col_ind, num)
    @board.each{|row| return true if @board[row][col_ind].eql?(num)}
    false
  end

  def in_box?(box, num)
    @boxes[box].include?(num)
  end

  def is_a_starting_number?(row, col)
    return true if starting numbers.include?([row.to_s, col.to_s])
    false
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
    #needs work
    @board.each do |row|
      row.join(" ")
    end
     @board.each do |row|
      row.join("\n")
    end
    # @board.join("\n")
    # p @board
  end

end


