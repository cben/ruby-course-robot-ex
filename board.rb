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
