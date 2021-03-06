
class Sudoku
  attr_reader :board, :boxes, :starting_numbers

  #Initializes Board
  def initialize(board_string)
    @board_string = board_string
    @board = generate_board
    @boxes = compile_all_boxes
    create_starting_numbers
  end

  #starting numbers gives the position of the intial numbers.
  def create_starting_numbers
    @board.each_index do |row|
      @board.each_index do |col|
        if @board[row][col].number != "-"
          @board[row][col].starting_number = true
        end
      end
    end
  end

  def board_full?
    @board.each_index do |row|
      @board[row].each_index do |col|
        if @board[row][col].number == "-"
          @board[row][col].number
          return false
        end
      end
    end
    true
  end

  def solve(row_index = 0, col_index = 0)
    return if game_over? == true

    reset_legal_moves
    set_legal_moves_for_all_squares

    min = smallest_moveset

    if min == 1
      fill_gimmes 
      solve
    else 
      first_square = find_first_square(min)

      i=0
      while i < min
        first_square.number = first_square.legal_moves[i]
        i+=1
        solve
        first_square.legal_moves[i] = "-"
      end
    end
  end


  def find_first_square(number)
    board.each_index do |row| 
      board.each_index do |col| 
        return board[row][col] if board[row][col].legal_moves.length == number
      end 
    end 
    puts "Square does not exist"    
  end 


  def fill_gimmes
    @board.each_index do |row_index| 
      @board.each_index do |col_index| 
        if @board[row_index][col_index].legal_moves.length == 1
          @board[row_index][col_index].number = @board[row_index][col_index].legal_moves[0]  
        end
      end 
    end 
  end

  #inputs
  def smallest_moveset
    smallest_moveset_length = 9
    board.each_index do |row|
      board.each_index do |col|
        cur=board[row][col].legal_moves.length
        if cur < smallest_moveset_length && cur !=0
          smallest_moveset_length = cur
        end
      end
    end
    smallest_moveset_length
  end

  def reset_legal_moves
    @board.each_index do |row_index| 
      @board.each_index do |col_index| 
        if board[row_index][col_index].number == "-"
          board[row_index][col_index].legal_moves = [] 
        end
      end
    end    
  end

  #game_over? should return false if board contains any "-".

  def set_legal_moves_for_all_squares
    board.each_index do |row|
      board[row].each_index do|col| 
        compile_legal_moves(board[row][col]) unless board[row][col].number != "-"
      end
    end
  end

  # input:  a Square object, output a sorted array of legal moves.  
  # This method sets the legal_moves attribute for a given square to an array of legal moves.  It returns that array for convenience and debugging even though it is destructive.
  # passes both tests.  might be good to write more tests
  def compile_legal_moves(square)
    ("1".."9").each{|num| square.legal_moves << num if is_legal?(num, square) && !square.legal_moves.include?(num)}
    square.legal_moves
  end

  def game_over?
    # if board_full? = true and each square is legal.
    board_full?
  end


  def is_legal?(num, square)
    # raise RuntimeError.new("you passed in a row of value #{row} and a column of value #{col}") if row>8 || col>8
    return false if in_row?(square.row_index, num) || in_column?(square.col_index, num) || in_box?(which_box(square.row_index, square.col_index), num)
    true
  end

  # takes in the index of a row and the number it is checking, and returns a boolean. Checks if a number is in a row already. Passes all tests.

  def in_row?(row, num)
    @board[row].each {|square| return true if square.number == num}
    false
  end

  #Functions
  def in_column?(column, num)
    transposed = @board.transpose
    transposed[column].each {|square| return true if square.number == num}
    false
  end

  #took out brackets because original code was returning (doesn't need brackets: "box[\"1\", \"-\", \"5\", \"-\", \"9\", \"-\", \"2\", \"-\", \"-\"]"
  #Functions
  def in_box?(box_key, num)
    @boxes[box_key].each {|square| return true if square.number == num}
    false

  end

  #returns true if there is a number at a specific coordinate (row,col).
  #Functions
  def is_a_starting_number?(row, col)
    return true if starting_numbers.include?([row.to_s, col.to_s])
    false
  end

  #input:  coordinates on the grid
  #output: 3x3 box (as a string) that includes the square at those coordinates

  #Takes row and col indeces as argument and returns which box the coordinate is located in.
  #functions
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
    if board[row_index][col_index].number != "-"
      return false
    else
      true
    end
  end

  # creates a new board in which each space is an instance of the Square class and each row is an array of squares.
  def generate_board
    board_array = @board_string.split("")
    @board = Array.new(9){board_array.shift(9)}
    for row in 0...@board.length
      for col in 0...@board.length
        @board[row][col] = Square.new(@board[row][col], row, col)
      end
    end
    create_starting_numbers
    @board
  end

  # prints out the board with just the number.
  def print_board
    print to_s
    # @board.each do |row|
    #   row.each do |square|
    #     print " #{square.number} "
    #   end
    #   puts ""
    # end
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

  # compile a single box into an array of Squares

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
    string_board = ""
    @board.each do |row|
      row.each do |square|
        string_board << " #{square.number} "
      end
      string_board << "\n"
    end
    string_board
  end

end

class Square

  attr_reader :coordinates, :row_index, :col_index
  attr_accessor :legal_moves, :number, :starting_number

  def initialize(number, row_index, col_index)
    @number=number
    @row_index=row_index
    @col_index=col_index
    @starting_number = false
    @legal_moves = []
    @last_number_placed
  end

end
