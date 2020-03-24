require_relative "board"

class Game
  def initialize
    @board = Board.new(Board.from_file("puzzles/sudoku1_almost.txt"))
  end

  def play
    until @board.solved?
      @board.render
      pos = get_position_input
      val = get_value_input
      @board[pos] = val
    end
    @board.render
    puts "You won!!!"
  end

  def get_position_input
    position_prompt
    pos = gets.chomp.split(",").map { |i| Integer(i) rescue nil }
    until pos.length == 2 && valid_position(pos) && @board[pos].given
      @board.render
      puts "Not a valid position!"
      puts "Please enter two comma separated values between 0 and 8: "
      print "> "
      pos = gets.chomp.split(",").map { |i| Integer(i) rescue nil }
    end
    pos
  end

  def get_value_input
    value_prompt
    value = gets.chomp.to_i
    until Set.new(1..9).include?(value)
      @board.render
      puts "Value must be between 1 and 9: "
      print "> "
      value = gets.chomp.to_i
    end
    value
  end

  def position_prompt
    puts "Enter the position of the tile you want to update (e.g. '0,0'): "
    print "> "
  end

  def value_prompt
    puts "Enter a value between 0 and 9: "
    print "> "
  end

  def valid_position(pos_array)
    valid_nums = Set.new(0..8)
    row, col = pos_array
    valid_nums.include?(row) && valid_nums.include?(col)
  end
end

g = Game.new
puts "Starting Sudoku..."
sleep(1)
g.play