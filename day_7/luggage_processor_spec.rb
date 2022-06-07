require 'rspec'
require_relative 'luggage_processor'

describe 'Day 7' do
  let(:input) do
    <<~TEXT
      light red bags contain 1 bright white bag, 2 muted yellow bags.
      dark orange bags contain 3 bright white bags, 4 muted yellow bags.
      bright white bags contain 1 shiny gold bag.
      muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
      shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
      dark olive bags contain 3 faded blue bags, 4 dotted black bags.
      vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
      faded blue bags contain no other bags.
      dotted black bags contain no other bags.
    TEXT
  end

  describe 'LuggageProcessor' do
    it 'finds the options of bags that can be used' do
      processor = LuggageProcessor.new(input)

      result = processor.options_for('shiny gold')

      expect(result).to contain_exactly('bright white', 'muted yellow', 'dark orange', 'light red')
    end
  end

  describe 'LuggageRulesParser' do
    it 'returns a hash' do
      rules = LuggageRulesParser.parse(input)

      expect(rules).to be_a(Hash)
    end

    it 'creates a hash with the rules' do
      expected_rules = {
        'light red' => ['bright white', 'muted yellow'],
        'dark orange' => ['bright white', 'muted yellow'],
        'bright white' => ['shiny gold'],
        'muted yellow' => ['shiny gold', 'faded blue'],
        'shiny gold' => ['dark olive', 'vibrant plum'],
        'dark olive' => ['faded blue', 'dotted black'],
        'vibrant plum' => ['faded blue', 'dotted black'],
        'faded blue' => [],
        'dotted black' => []
      }

      parsed_rules = LuggageRulesParser.parse(input)
      expect(parsed_rules).to eq(expected_rules)
    end
  end
end
