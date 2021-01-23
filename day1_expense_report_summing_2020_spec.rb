require 'rspec'
require './day1_expense_report_summing_2020.rb'

describe 'find values that sum 2020' do
  context 'with two values in the list' do
    it 'throws an error if no values match 2020' do
      input = [1, 1]
      expect { ExpenseReportPuzzle.run(input) }.to raise_error(StandardError, 'No numbers found in the input that sum 2020')
    end

    it 'does not consider the same number as two different numbers' do
      input = [20, 1_010, 30]
      expect { ExpenseReportPuzzle.run(input) }.to raise_error(StandardError, 'No numbers found in the input that sum 2020')
    end

    it 'works with two numbers' do
      input = [1_000, 1_020]
      expect(ExpenseReportPuzzle.run(input)).to eq(1_020_000)
    end

    it 'works with more than two numbers' do
      input = [3, 1_000, 1_020]
      expect(ExpenseReportPuzzle.run(input)).to eq(1_020_000)
    end
  end
end
