require 'set'

class LuggageProcessor
  def initialize(input, parser = LuggageRulesParser)
    @rules = parser.parse(input)
  end

  def options_for(bag)
    result = Set.new

    @rules.each do |outer_bag, inner_bags|
      result << outer_bag if inner_bags.include?(bag)
    end
    result.each do |available_bag|
      result = result.union(options_for(available_bag))
    end

    result
  end

end

# Create the array in the opposite fashion => inner to outer?

class LuggageRulesParser
  def self.parse(input)
    result = {}
    rules_list = input.split("\n")
    rules_list.each do |rule|
      outer_bag, inner_bags = rule.split(' contain ')
      outer_bag.delete_suffix!(' bags')

      result[outer_bag] = inner_bag_colors(inner_bags)
    end

    result
  end

  private

  def self.inner_bag_colors(inner_bags)
    inner_bags.gsub!(/(\d|bags?\.?)/, '')
    inner_bags = inner_bags.split(',').map(&:strip)

    inner_bags.delete('no other')
    inner_bags
  end
end

official_input = File.open("day_7/input.txt").read
puts LuggageProcessor.new(official_input).options_for('shiny gold')
puts LuggageProcessor.new(official_input).options_for('shiny gold').size

