require_relative 'sudoku'

# The sudoku puzzles that your program will solve can be found
# in the sudoku_puzzles.txt file.
#
# Currently, Line 16 defines the variable board_string to equal
# the first puzzle (i.e., the first line in the .txt file).
# After your program can solve this first puzzle, edit
# the code below, so that the program tries to solve
# all of the puzzles.
#
# Remember, the file has newline characters at the end of each line,
# so we call String#chomp to remove them.


board_string = File.readlines('sudoku_puzzles.txt').first.chomp

game = Board.new(board_string)



# game.solve
# puts game


game.board.each{|row| p row}


puts "------------------"


require_relative 'sudoku'

# The sudoku puzzles that your program will solve can be found
# in the sudoku_puzzles.txt file.
#
# Currently, Line 16 defines the variable board_string to equal
# the first puzzle (i.e., the first line in the .txt file).
# After your program can solve this first puzzle, edit
# the code below, so that the program tries to solve
# all of the puzzles.
#
# Remember, the file has newline characters at the end of each line,
# so we call String#chomp to remove them.


board_string = File.readlines('sudoku_puzzles.txt').first.chomp

game = Board.new(board_string)



# game.solve
# puts game


# game.board.each{|row| p row}


# puts "------------------"



# game.solve
# game.in_column?(0, "1")


# p game.solve
# 81 spots
# 9 spots already in place
# 72 other possibilities
# Should only be able to take from a pool of 1..9, 8 times
# p game.create_starting_numbers

# p game.in_box?("box_9", "9")
# p game.game_over?
# p game.is_legal?("5",8,8)
# p game.in_row?(0, "4")
# p game.in_column?(0, "5")
# p game.compile_all_boxes
# p game.is_a_starting_number?(1, 0)
 p game.which_box(8, 8)
