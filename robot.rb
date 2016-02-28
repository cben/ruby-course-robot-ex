module Parser
  # May return a string to print
  def execute_line(line)
    case line.strip
    when /^PLACE\s+(\d+)\s*,\s*(\d+)\s*,\s*(\w+)$/
      place($1.to_i, $2.to_i, $3.downcase.to_sym)
    when /^MOVE$/
      move
    when /^LEFT$/
      left
    when /^RIGHT$/
      right
    when /^REPORT$/
      report
    when /^$/
      nil
    else
      "Didn't understand command: #{line}"
    end
  end

  def execute_file(path)
    File.foreach(path) do |line|
      result = execute_line(line)
      puts result if result.kind_of?(String)
    end
  end
end

class Robot
  include Parser

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

class Board
  # dir => (dx, dy)
  DIRECTIONS = {
    # Important: order is clockwise
    north: [0, +1],
    east: [+1, 0],
    south: [0, -1],
    west: [-1, 0]
  }

  def initialize
    @width, @height = 5, 5
  end

  def validate(x, y, facing)
    (0...@width).cover?(x) && (0...@height).cover?(y) && DIRECTIONS.has_key?(facing)
  end

  def clockwise(facing)
    keys = DIRECTIONS.keys
    keys[(keys.index(facing) + 1) % keys.size]
  end

  def counterclockwise(facing)
    keys = DIRECTIONS.keys
    keys[(keys.index(facing) - 1) % keys.size]
  end
end
