class Sudoku
  attr_reader :board, :boxes, :starting_numbers

  #Initializes Board
  #ZM: you board needs a collection of just all the cells, regardless of their box/row/column. Just a pure collection of all 64 cells.
  #That would make your code a lot easier to operate on. 
  def initialize(board_string)
    @board_string = board_string
    @board = generate_board
    @boxes = compile_all_boxes
    create_starting_numbers
  end

  #starting numbers gives the position of the intial numbers.
  #ZM: This should be something that happens on the initialization of the cell. It should check if you've given it a number of a dash, and set it's internal variable @starting_number == to the equivlent
  def create_starting_numbers
    @board.each_index do |row|
      @board.each_index do |col|
        if @board[row][col].number != "-"
          @board[row][col].starting_number = true
        end
      end
    end
  end

  #ZM: This entire function would be turned into a any statement with Enumberables. 
  #ZM: This would work if you had a collection of all the cells on the board.
  #And you also had a empty? method on the cell that checked if its number was "-" or (1..9)
  # @board.cells.any?{|cell| cell.empty? }
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
    #ZM: return if game_over? no need for the  == true
    return if game_over? == true

    #ZM: Good use of calling metods here
    reset_legal_moves
    set_legal_moves_for_all_squares

    min = smallest_moveset

    #ZM The if else on this is hard to understand... Keep nesting limited to a minumum, the fill_gimmes should be part of solve so i would assume it would look something like this.
    # return solve if min == 1
    # 
    # Then put the logic to do the other solution if the min is not 1, although im still not sure what that means
    if min == 1
      #ZM: Why isn't fill_gimmes a part of solve? 
      fill_gimmes 
      solve
    else 
      first_square = find_first_square(min)
      
      #ZM: There is no reason to set an i=0 here... there are 10 different ways to do this i ruby that are more conventional.
      # for i in (0..min) 
      i=0
      while i < min
        first_square.number = first_square.legal_moves[i]
        i+=1
        solve
        #ZM: Why is this line important?
        first_square.legal_moves[i] = "-"
      end
    end
  end

  #ZM: The use / need of this method escapes me. I'm not sure what's happening with it.   
  def find_first_square(number)
    #ZM: You can use first here instead of doing a nested loop with a return statement. 
    #board.cells.find{|cell| cell.leagh_moves.length == number}
    board.each_index do |row| 
      board.each_index do |col| 
        return board[row][col] if board[row][col].legal_moves.length == number
      end 
    end 
    puts "Square does not exist"    
  end 


  def fill_gimmes
    #ZM: So you solution still requires you to have this nested loops, which is not bad, but it looks rough. Then you are operating off the subset of squres
    # available to you. You should try something like...
    #
    # gimmies = @board.cells.select{|cell| cell.legal_moves.length == 1}
    # gimmies.each{|cell| cell.number = cell.legal_moves.first}
    
    @board.each_index do |row_index| 
      @board.each_index do |col_index| 
        #ZM: You keep accessing the board as @board[row][col], you should create a get_cell method that does this logic for you
        if @board[row_index][col_index].legal_moves.length == 1
          @board[row_index][col_index].number = @board[row_index][col_index].legal_moves[0]  
        end
      end 
    end 
  end

  #inputs
  #ZM: I am not really sure what the purpose of this method is. That is a code smell in itself.
  # You should be asking yourself, what is the purpose of this method, what are the expected inputs, outputs, and how can i test it success
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
        #ZM: if board[row][cell].is_empty? reads a lot better, then you only have to check for the string "-" in one place
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
        #ZM: I would put a method on my cell... ss_empty?... that would internally check for the "-"
        compile_legal_moves(board[row][col]) unless board[row][col].number != "-"
      end
    end
  end

  # input:  a Square object, output a sorted array of legal moves.  
  # This method sets the legal_moves attribute for a given square to an array of legal moves.  It returns that array for convenience and debugging even though it is destructive.
  # passes both tests.  might be good to write more tests
  def compile_legal_moves(square)
    #ZM: General Convention, if thhere is more then 1 thing happening in the block, break it out into the do / end syntax 
    ("1".."9").each{|num| square.legal_moves << num if is_legal?(num, square) && !square.legal_moves.include?(num)}
    square.legal_moves
  end

  def game_over?
    # if board_full? = true and each square is legal.
    board_full?
  end


  def is_legal?(num, square)
    #ZM: the return false if is not necessary you can just do the inverse of the logical operator
    # !(in_row? || in_column? || in_box?)
    # raise RuntimeError.new("you passed in a row of value #{row} and a column of value #{col}") if row>8 || col>8
    return false if in_row?(square.row_index, num) || in_column?(square.col_index, num) || in_box?(which_box(square.row_index, square.col_index), num)
    true
  end

  # takes in the index of a row and the number it is checking, and returns a boolean. Checks if a number is in a row already. Passes all tests.

  def in_row?(row, num)
    #ZM: Use the any? Enumerable method here
    @board[row].each {|square| return true if square.number == num}
    false
  end

  #Functions
  def in_column?(column, num)
    transposed = @board.transpose
    #ZM: Use the any? Enumerable method here
    transposed[column].each {|square| return true if square.number == num}
    false
  end

  #took out brackets because original code was returning (doesn't need brackets: "box[\"1\", \"-\", \"5\", \"-\", \"9\", \"-\", \"2\", \"-\", \"-\"]"
  #Functions
  def in_box?(box_key, num)
    #ZM: doing the return inside of the each block is incorrect. You should use an enumerable method such as any?
    # @boxes[box_key].any?{ |square| squre.number == num  }
    @boxes[box_key].each {|square| return true if square.number == num}
    false

  end

  #returns true if there is a number at a specific coordinate (row,col).
  #Functions
  def is_a_starting_number?(row, col)
    #ZM: You don't need the ternary here you can just do the logical operation and it will return. 
    # starting_number.include?([row.to_s,col.to_s])
    return true if starting_numbers.include?([row.to_s, col.to_s])
    false
  end

  #input:  coordinates on the grid
  #output: 3x3 box (as a string) that includes the square at those coordinates

  #Takes row and col indeces as argument and returns which box the coordinate is located in.
  #functions
  #ZM: Two code Smells here...
  # 1. you have hard coded in return values that are string literals. What happens if you change the name of box_4 to be squre_5, this is one more place you have to updated it.
  # 2. This big If / elseif statement is out of convention. Think of a way you can hashes, iteration, or collections to reduce the amount of code you wrote here. 
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
  
  #ZM: You don't need the if else here... Just do the logical statement and it will return
  def square_is_empty?(row_index, col_index)
    #board[row_index][col_index].number != "-"
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
  # Delete these commented  out lines of code rable rable
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
    #ZM: Reduce the code by using proper Enumerable Methods
    #ZM: What is the +2 doing in this context? It is generally bad practice
    # Have literal numbers floating around, define to to a constant and use that instead. 
    box=[]
    for row in start_row..(start_row+2)
      for col in start_col..(start_col+2)
        box << @board[row][col]
      end
    end
    box
  end

  #ZM: If you are not using the variable in the method, then make sure you remove it from the signature. 
  def compile_row(string, length)
    string.split("")
  end

  # Returns a string representing the current state of the board
  # ZM: You can minimize the amount of code here by using a map, and join statement
  # Think about how we did it in the boggle board.
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
