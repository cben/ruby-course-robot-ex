require './board.rb'

class Robot
  def initialize
    @board = Board.new
    @x = @y = @facing = nil  # until first valid place()
  end

  def placed?
    @facing != nil
  end

  attr_reader :x, :y, :facing

  def place(x, y, facing)
    @x, @y, @facing = x, y, facing if @board.validate(x, y, facing)
  end

  def report
    if placed?
      "At (#{@x}, #{@y}) facing #{@facing.to_s.upcase}."
    else
      "Not placed."
    end
  end

  def move
    return unless placed?
    dx, dy = Board::DIRECTIONS[@facing]
    place(@x + dx, @y + dy, @facing)
  end

  def right
    return unless placed?
    place(@x, @y, @board.clockwise(@facing))
  end

  def left
    return unless placed?
    place(@x, @y, @board.counterclockwise(@facing))
  end
end
