require "set"
require_relative "tile"

class Board
  def self.from_file(filename)
    File.readlines(filename).map do |line|
      line.chomp.split("").map do |value|
        num_value = value.to_i
        if num_value == 0
          Tile.new(" ", true)
        else
          Tile.new(num_value, false)
        end
      end
    end
  end

  def self.print_grid(arr)
    arr.each { |row| puts row.join(" ") }
  end

  def initialize(grid)
    @grid = grid
  end

  def [](position)
    row, col = position
    @grid[row][col]
  end

  def []=(position, value)
    row, col = position
    @grid[row][col] = Tile.new(value, true)
  end

  def render
    system("clear")
    puts "+ --- + --- + --- + --- + --- + --- + --- + --- + --- +"
    @grid.each do |row|
      print "|  "
      formatted_row = row.map { |tile| "#{tile.to_s}  | " }
      puts formatted_row.join(" ")
      puts "+ --- + --- + --- + --- + --- + --- + --- + --- + --- +"
    end
  end

  def solved?
    rows_valid? && cols_valid? && grid_valid?
  end

  def contains_all_nums?(other_set)
    Set.new(1..9) == other_set
  end

  def rows_valid?
    @grid.each do |row|
      row_set = Set.new()
      row.each { |tile| row_set.add(tile.value) }
      return false if !contains_all_nums?(row_set)
    end
    true
  end

  def cols_valid?
    @grid.transpose.each do |col|
      col_set = Set.new()
      col.each { |tile| col_set.add(tile.value) }
      return false if !contains_all_nums?(col_set)
    end
    true
  end

  def grid_valid?
    partition_grid.each do |subgrid|
      return false if !subgrid_valid?(subgrid)
    end
    true
  end

  def subgrid_valid?(subgrid)
    subgrid_set = Set.new()
    subgrid.each do |row|
      row.each { |value| subgrid_set.add(value) }
    end
    contains_all_nums?(subgrid_set)
  end

  def partition_rows
    partitioned_rows = []
    @grid.each do |row|
      row.each_slice(3) do |subrow|
        partitioned_rows << (subrow.map { |tile| tile.value })
      end
    end
    partitioned_rows
  end

  def partition_grid
    tmp_arr = []
    subgrids = []
    partition_rows.each_slice(3) { |row| tmp_arr << row }
    tmp_arr.transpose.each do |col|
      col.each_slice(3) { |subgrid| subgrids << subgrid }
    end
    subgrids
  end
end