require "./parser.rb"

describe Parser do
  it "parses a line" do
    robot = Parser.new
    robot.execute_line("PLACE 2, \t3,North")
    expect(robot.execute_line("xyzPLACE 0, 0, SOUTH")).to match(/^Didn't understand/)
    expect(robot.execute_line("REPORT")).to eq("At (2, 3) facing NORTH.")
  end

  it "parses a file" do
    path = File.expand_path("test1.txt", File.dirname(__FILE__))
    expect { Parser.new.execute_file(path) }
      .to output("Not placed.\n" +
                 "At (3, 3) facing NORTH.\n").to_stdout
  end
end
