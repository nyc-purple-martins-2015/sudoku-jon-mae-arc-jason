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


# board_string = File.readlines('sudoku_puzzles.txt').first.chomp
# p board_string[2]

lines = {}
board_string = File.readlines('sudoku_puzzles.txt')

i=1
lines={}

board_string.each do |board| 
	lines["line_#{i}"]=board
	i+=1
end


game = Sudoku.new(lines["line_1"])
game.set_legal_moves_for_all_squares
game.print_board
# p game.board
puts ""
puts "-----------------------"
puts ""
# p game.find_first_square(2)
# game.solve
# game.print_board
p game.smallest_moveset


