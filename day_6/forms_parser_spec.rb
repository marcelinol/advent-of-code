require 'rspec'
require_relative 'forms_parser'

describe 'Day 6' do
  describe 'FormsParser' do
    describe '#count_yes' do
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

    describe '#count_yes_from_everyone_in_a_group' do
      let(:input) do
        <<~TEXT
            b
            bc
  
            a
  
            koi
            kob
            ko

            a
            f
        TEXT
      end

      it 'counts letters present in all answers of each group' do
        parser = FormsParser.new(input)

        expect(parser.count_unanimous_yes).to eq(4)
      end
    end
  end
end