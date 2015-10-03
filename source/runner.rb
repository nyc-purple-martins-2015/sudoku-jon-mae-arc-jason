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



# game.solve
# puts game


game.board.each{|row| p row}


puts "------------------"

# p game.compile_all_boxes
# game.test_box.each{|box| p box}
# p game.boxes
# p game.in_box?("box_1", "5")
# p game.in_box?("box_1", "6")
# p game.which_box(0,5)
# p game.starting_numbers
# game.solve
# game.board.each{|row| p row}
# game.in_column?(0,"8")
game.game_over?
puts game.square_is_empty?(0, 1)
puts game.square_is_empty?(0, 2)
puts game.square_is_empty?(0, 3)
puts game.square_is_empty?(0, 4)
puts game.square_is_empty?(0, 5)
# game.in_row?("3")

