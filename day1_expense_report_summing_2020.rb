# the Elves in accounting just need you to fix your expense report (your puzzle input); apparently, something isn't quite adding up.
#
# Specifically, they need you to find the two entries that sum to 2020 and then multiply those two numbers together.
#
# For example, suppose your expense report contained the following:
#
# 1721
# 979
# 366
# 299
# 675
# 1456
#
# In this list, the two entries that sum to 2020 are 1721 and 299. Multiplying them together produces 1721 * 299 = 514579, so the correct answer is 514579.
# Of course, your expense report is much larger. Find the two entries that sum to 2020; what do you get if you multiply them together?

class ExpenseReportPuzzle
  def self.run(input)
    input.each_with_index do |pivot, index|
      input.slice((index + 1)..-1).each do |number|
        return pivot * number if pivot + number === 2020
      end
    end

    raise StandardError, "No numbers found in the input that sum 2020"
  end
end

# require 'benchmark'
# # This report shows the user CPU time, system CPU time, the sum of the user and system CPU times, and the elapsed real time. The unit of time is seconds.
# official_input = File.open("day1_input.txt").map(&:to_i);false
# puts Benchmark.measure { ExpenseReportPuzzle.run(official_input) }
#
# puts ExpenseReportPuzzle.run(official_input)
