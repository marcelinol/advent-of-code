require 'rspec'
require_relative 'forms_parser'

describe 'Day 6' do
  describe 'FormsParser' do
    context 'when there are no repetitions' do
      let(:input) do
        <<~TEXT
          a
          bc
        TEXT
      end

      it 'counts letters in one group' do
        parser = FormsParser.new(input)

        expect(parser.count_yes).to eq(3)
      end
    end

    context 'with repetitions' do
      let(:input) do
        <<~TEXT
          b
          bc
        TEXT
      end

      it 'counts letters in one group' do
        parser = FormsParser.new(input)

        expect(parser.count_yes).to eq(2)
      end
    end

    context 'with multiple groups' do
      let(:input) do
        <<~TEXT
          b
          bc

          a

          kju
        TEXT
      end

      it 'counts letters' do
        parser = FormsParser.new(input)

        expect(parser.count_yes).to eq(6)
      end
    end
  end
end