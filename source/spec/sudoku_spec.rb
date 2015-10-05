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

describe '#which_box' do
	let(:game) {Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--")}
	it 'expects which_box(0, 0) to return box_1' do
		expect(game.which_box(0, 0)).to eql("box_1")
	end

	it 'expects which_box(3, 5) to return box_3' do
		expect(game.which_box(3, 5)).to eql("box_5")
	end
end

describe '#square_is_empty?' do
	let(:game) {Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--")}
	it 'expects square_is_empty?(0, 5) to be false ' do
		expect(game.square_is_empty?(0, 5)).to eql(false)
	end

	it 'expects square_is_empty?(0, 1) to be true' do
		expect(game.square_is_empty?(0, 1)).to eql(true)
	end
end

describe '#in_row?' do
	let(:game) {Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--")}
	it 'expects in row?(0, "5") to be true' do
		expect(game.in_row?(0, "5")).to eql(true)
	end

	it 'expects in row?(0, "6") to be false' do
		expect(game.in_row?(0, "6")). to eql(false)
	end
end

describe '#in_column?' do
	let(:game) {Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--")}
	it 'expects in_column?(0, "2") to be true' do
		expect(game.in_row?(0, "2")).to eql(true)
	end
	it 'expects in_column ?(0, "3") to be false' do
		expect(game.in_row?(0, "3")). to eql(false)
	end
end

describe '#in_box?' do
	let(:game) {Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--")}
	it 'expects in_box?(0, "9") to be true' do
		expect(game.in_box?("box_1", "9")).to eql(true)
	end
	it 'expects in_box?(0, "3") to be false' do
		expect(game.in_box?("box_1", "3")). to eql(false)
	end
end

describe '#is_legal?' do
	let(:game) {Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--")}
	let(:square) {Square.new("-", 2, 2)}
	let(:square_2) {Square.new("-", 4, 8)}
	it 'expects is_legal?("3", square) to be true' do
		expect(game.is_legal?("3", square)).to eql(true)
	end
	it 'expects is_legal?("6", square) to be false' do
		expect(game.is_legal?("4", square)). to eql(false)
	end
	it 'expects is_legal?("7", square) to be false' do
		expect(game.is_legal?("7", square)). to eql(false)
	end
	it 'expects is_legal?("3", square_2) to be false' do
		expect(game.is_legal?("3", square_2)). to eql(false)
	end
end

describe '#compile_legal_moves' do
	let (:game) {Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--")}
	let(:square) {Square.new("-", 2, 2)}
	let(:square_2) {Square.new("-", 4, 8)}

	it 'expects square.legal_moves to contain 3, 6' do
		game.compile_legal_moves(square)
		expect(square.legal_moves.sort).to eql(["3","6"])
	end

	it 'expects square_2.legal_moves to contain 3, 6' do
		game.compile_legal_moves(square_2)
		expect(square_2.legal_moves.sort).to eql(["4"])
	end
end

describe '#find_first_square' do
	let (:game) {Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--")}
	let(:square) {Square.new("-", 0, 1)}

	it 'returns the first square with two legal moves' do
		game.set_legal_moves_for_all_squares
		expect(game.find_first_square(2)).to eql game.board[0][1]
	end
end

describe '#smalleset_moveset' do
	let (:game) {Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--")}
	let(:square) {Square.new("-", 0, 1)}

	it 'returns the smallest moveset possesed by an unfilled square (as an integer)' do
		game.set_legal_moves_for_all_squares
		expect(game.smalleset_moveset).to eql(1)
	end
end






