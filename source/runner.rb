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

game = Sudoku.new(board_string)

game.print_board
# game.create_starting_numbers
# p game.board_full?
# p game.board

# game.solve
# puts game


# game.board.each{|row| p row}


puts "------------------"



# game.solve
# game.in_column?(0, "1")

# p game.is_legal?("1", 0, 0)

# 81 spots
# 9 spots already in place
# 72 other possibilities
# Should only be able to take from a pool of 1..9, 8 times





