require "test/unit/assertions"
include Test::Unit::Assertions

class Sudoku
  def initialize(data)
    @data = data
  end

  def valid?
    # rows
    n = @data.length
    # at least 1 row
    return false if n <= 0
    # number of rows are square number
    m = Integer.sqrt(n)
    return false if m ** 2 != n
    #first row has cols equal to n
    return false if @data[0].length != n
    # all cols the same length
    return false if @data.map { |d| d.length}.uniq.length != 1
    #all data is integers
    return false if @data.flatten.all? { |d| d.is_a? Integer } == false

    #check numbers
    check = true
    #check rows
    @data.map do |row|
      check = check && row.min == 1 && row.max == n && row.uniq.length == n
    end

    #check columns
    @data.transpose.map do |col|
      check = check && col.min == 1 && col.max == n && col.uniq.length == n
    end

    #check squares
    (0..(m - 1)).map do |x|
      (0..(m - 1)).map do |y|
        sq = @data.drop(m * x).take(m).map { |d| d.drop(m * y).take(m) }.flatten
        check = check && sq.min == 1 && sq.max == n && sq.uniq.length == n
      end
    end

    return check
  end
end

# Valid Sudoku
goodSudoku1 = Sudoku.new([
  [7,8,4, 1,5,9, 3,2,6],
  [5,3,9, 6,7,2, 8,4,1],
  [6,1,2, 4,3,8, 7,5,9],

  [9,2,8, 7,1,5, 4,6,3],
  [3,5,7, 8,4,6, 1,9,2],
  [4,6,1, 9,2,3, 5,8,7],

  [8,7,6, 3,9,4, 2,1,5],
  [2,4,3, 5,6,1, 9,7,8],
  [1,9,5, 2,8,7, 6,3,4]
])

goodSudoku2 = Sudoku.new([
  [1,4, 2,3],
  [3,2, 4,1],

  [4,1, 3,2],
  [2,3, 1,4]
])

# Invalid Sudoku
badSudoku1 = Sudoku.new([
  [0,2,3, 4,5,6, 7,8,9],
  [1,2,3, 4,5,6, 7,8,9],
  [1,2,3, 4,5,6, 7,8,9],

  [1,2,3, 4,5,6, 7,8,9],
  [1,2,3, 4,5,6, 7,8,9],
  [1,2,3, 4,5,6, 7,8,9],

  [1,2,3, 4,5,6, 7,8,9],
  [1,2,3, 4,5,6, 7,8,9],
  [1,2,3, 4,5,6, 7,8,9]
])

badSudoku2 = Sudoku.new([
  [1,2,3,4,5],
  [1,2,3,4],
  [1,2,3,4],
  [1]
])

assert_equal(goodSudoku1.valid?, true)
assert_equal(goodSudoku2.valid?, true)
assert_equal(badSudoku1.valid?, false)
assert_equal(badSudoku2.valid?, false)
