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
    row * 8 + column
  end
end

official_input = File.open("day_5/input.txt")
highest_seat_id = 0
official_input.each do |seat_code|
  seat = Seat.new(seat_code)
  highest_seat_id = seat.seat_id if seat.seat_id > highest_seat_id
end
puts highest_seat_id