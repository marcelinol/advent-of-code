require 'rspec'
require_relative 'day1_expense_report_summing_2020'

describe 'Day 1' do
  describe 'find 2 values that sum 2020' do
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

  describe 'find 3 values that sum 2020' do
    context 'with two values in the list' do
      it 'throws an error if no values match 2020' do
        input = [1, 1, 1]
        expect { ExpenseReportPuzzle.run_part_two(input) }.to raise_error(StandardError, 'No numbers found in the input that sum 2020')
      end

      it 'does not consider the same number as two different numbers' do
        input = [20, 1_010, 30]
        expect { ExpenseReportPuzzle.run_part_two(input) }.to raise_error(StandardError, 'No numbers found in the input that sum 2020')
      end

      it 'works with three numbers' do
        input = [1_000, 1_000, 20]
        expect(ExpenseReportPuzzle.run_part_two(input)).to eq(20_000_000)
      end

      it 'works with more than three numbers' do
        input = [3, 1_000, 1_001, 19]
        expect(ExpenseReportPuzzle.run_part_two(input)).to eq(19_019_000)
      end
    end
  end
end
