# https://adventofcode.com/2020/day/5

class Seat
  def initialize(seat_code)
    @binary_seat_code = seat_code.gsub(/[FBLR]/, 'F' => 0, 'B' => '1', 'L' => 0, 'R' => '1')
  end

  def row
    @binary_seat_code[0..6].to_i(2)
  end

  def column
    @binary_seat_code[7..9].to_i(2)
  end

  def seat_id
    # Not happy with this
    self.class.calculate_seat_id(row: row, column: column)
  end

  def self.calculate_seat_id(row:, column:)
    row * 8 + column
  end
end

class EmptySeatFinder
  def initialize(seats)
    @seats = seats
  end

  # Not very happy with this
  def find_seat_id
    grouped_seats_by_row = group_seats_by_row(@seats)
    grouped_seats_by_row.each do |row, seats|
      next if seats.size == 8

      seat_columns = seats.map(&:column)
      empty_seat_columns = (0..7).to_a - seat_columns
      empty_seat_column = (empty_seat_columns - [0,7])[0] # this returns an array. I want its first (and only) element

      return Seat.calculate_seat_id(row: row, column: empty_seat_column)
    end
  end

  private
  def group_seats_by_row(seats)
    result = {}
    seats.each do |seat|
      result[seat.row] ||= []
      result[seat.row] << seat
    end

    result
  end
end

official_input = File.open("day_5/input.txt")
# highest_seat_id = 0
# official_input.each do |seat_code|
#   seat = Seat.new(seat_code)
#   highest_seat_id = seat.seat_id if seat.seat_id > highest_seat_id
# end
# puts highest_seat_id
#
# empty_seat_finder = EmptySeatFinder.new(official_input.map { |seat_code| Seat.new(seat_code) })
# puts empty_seat_finder.find_seat_id