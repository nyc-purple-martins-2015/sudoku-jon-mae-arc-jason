require_relative 'sudoku'

describe 'Sudoku' do
  it 'expects Sudoku to be a class' do
    expect(Sudoku).to be_a(Class)
  end
end

describe '#initialize(board_string)' do 
	let(:game) {Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--")}
	it 'expects Sudoku to take a string' do
		expect(game.board).to be_a Array
	end
end 


describe '#game_over?' do 
	let(:game) {Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--")}
	it 'expects game_over? to return false when the board is not yet full' do
	expect(game.game_over?).to eq(false)
	end
end

describe '#create_starting_numbers' do 
	let(:game) {Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--")}
	it 'expects create_starting_numbers to return an array' do 
		expect(game.create_starting_numbers).to be_a Array
	end 
end 






