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
# p "3 is a legal move at row 2, index 1: #{game.is_legal?("3", game.board[2][2])}"

puts "------------------"
# game.compile_legal_moves
p game.compile_legal_moves(game.board[2][2])
# p game.compile_legal_moves(game.board[2][2])

# game.boxes.each{|box_name, box_content| print "#box name: {box_name}\nbox value: #{box_content}\n-------\n"}
# p game.which_box(8,7)
# game.is_legal?("3", )
