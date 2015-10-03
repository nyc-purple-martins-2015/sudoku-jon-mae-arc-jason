require_relative 'sudoku'

describe 'Sudoku' do
  it 'expects Sudoku to be a class' do
    expect(Sudoku).to be_a(Class)
  end
end




# solve a row
# solve a column
# solve solve a box
