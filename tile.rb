require "colorize"

class Tile
  attr_reader :value, :given

  def initialize(value, given)
    @value = value
    @given = given
  end

  def value=(new_val)
    @value = new_val if @given 
  end

  def to_s
    if @given
      return @value.to_s
    else
      return @value.to_s.colorize(:green)
    end
  end
end

# t = Tile.new(2, false)
# puts t.to_s

# puts String.colors