class FormsParser
  def initialize(input)
    @input = input.split("\n\n")
  end

  def count_yes
    @input.map do |group|
      group.gsub("\n", "").chars.uniq.size
    end.sum
  end

  def count_unanimous_yes
    @input.map do |group|
      answers = group.split("\n")
      count_unanimous_yes_for_group(answers)
    end.sum
  end

  private

  def count_unanimous_yes_for_group(answers)
    responded_yes = answers.first.chars
    answers.each { |answer| responded_yes &= answer.chars }
    responded_yes.size
  end
end

# puts FormsParser.new(File.read("day_6/input.txt")).count_yes
# puts FormsParser.new(File.read("day_6/input.txt")).count_unanimous_yes