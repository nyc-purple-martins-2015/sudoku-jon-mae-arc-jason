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


