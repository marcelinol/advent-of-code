class FormsParser
  def initialize(input)
    @input = input.split("\n\n").map { |group| group.gsub("\n", "") }
  end

  def count_yes
    @input.map { |group| group.chars.uniq.size }.sum
  end
end

# puts FormsParser.new(File.read("day_6/input.txt")).count_yes