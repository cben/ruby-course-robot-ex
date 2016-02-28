require_relative "./robot.rb"

describe Robot do
  it "knows its x,y,facing" do
    robot = Robot.new
    robot.place(2, 3, :north)
    expect(robot.x).to eq(2)
    expect(robot.y).to eq(3)
    expect(robot.facing).to eq(:north)
  end

  it "reports state" do
    robot = Robot.new
    robot.place(2, 3, :north)
    expect(robot.report).to eq("At (2, 3) facing NORTH.")
  end

  it "ignores wrong position" do
    robot = Robot.new
    robot.place(5, 0, :north)
    expect(robot.report).to eq("Not placed.")
  end

  it "ignores wrong facing" do
    robot = Robot.new
    robot.place(0, 0, :widdershins)
    expect(robot.report).to eq("Not placed.")
  end

  it "moves" do
    robot = Robot.new
    robot.place(2, 3, :north)
    robot.move
    expect(robot.report).to  eq("At (2, 4) facing NORTH.")
  end

  it "doesn't fall off" do
    robot = Robot.new
    robot.place(0, 4, :north)
    robot.move
    expect(robot.report).to  eq("At (0, 4) facing NORTH.")
    robot.place(0, 0, :west)
    robot.move
    expect(robot.report).to  eq("At (0, 0) facing WEST.")
  end

  it "rotates" do
    robot = Robot.new
    robot.place(2, 3, :north)
    ["NORTH", "EAST", "SOUTH", "WEST", "NORTH"].each do |expected|
      expect(robot.report).to eq("At (2, 3) facing #{expected}.")
      robot.right
    end

    robot.place(2, 3, :north)
    ["NORTH", "WEST", "SOUTH", "EAST", "NORTH"].each do |expected|
      expect(robot.report).to eq("At (2, 3) facing #{expected}.")
      robot.left
    end
  end

  it "ignores commands before placed" do
    robot = Robot.new
    robot.right
    robot.move
    robot.left
    expect(robot.report).to eq("Not placed.")
  end

  it "parses a line" do
    robot = Robot.new
    robot.execute_line("PLACE 2, \t3,North")
    expect(robot.execute_line("xyzPLACE 0, 0, SOUTH")).to match(/^Didn't understand/)
    expect(robot.execute_line("REPORT")).to eq("At (2, 3) facing NORTH.")
  end

  it "parses a file" do
    path = File.expand_path("test1.txt", File.dirname(__FILE__))
    expect { Robot.new.execute_file(path) }
      .to output("Not placed.\n" +
                 "At (3, 3) facing NORTH.\n").to_stdout
  end
end
