require './robot.rb'

class Parser
  def initialize
    @robot = Robot.new
  end

  # May return a string to print
  def execute_line(line)
    case line.strip
    when /^PLACE\s+(\d+)\s*,\s*(\d+)\s*,\s*(\w+)$/
      @robot.place($1.to_i, $2.to_i, $3.downcase.to_sym)
    when /^MOVE$/
      @robot.move
    when /^LEFT$/
      @robot.left
    when /^RIGHT$/
      @robot.right
    when /^REPORT$/
      @robot.report
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

