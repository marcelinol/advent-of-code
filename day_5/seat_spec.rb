require 'rspec'
require_relative 'seat'

describe 'Day 5', :aggregate_failures do
  describe 'Seat' do
    it 'gets row from seat code' do
      expect(Seat.new('FBFBBFFRLR').row).to eq(44)
      expect(Seat.new('BFFFBBFRRR').row).to eq(70)
      expect(Seat.new('FFFBBBFRRR').row).to eq(14)
      expect(Seat.new('BBFFBBFRLL').row).to eq(102)
    end

    it 'gets column from seat code' do
      expect(Seat.new('FBFBBFFRLR').column).to eq(5)
      expect(Seat.new('BFFFBBFRRR').column).to eq(7)
      expect(Seat.new('BBFFBBFRLL').column).to eq(4)
    end

    it 'gets seat id from seat code' do
      expect(Seat.new('FBFBBFFRLR').seat_id).to eq(357)
      expect(Seat.new('BFFFBBFRRR').seat_id).to eq(567)
      expect(Seat.new('FFFBBBFRRR').seat_id).to eq(119)
      expect(Seat.new('BBFFBBFRLL').seat_id).to eq(820)
    end
  end

  describe 'EmptySeatFinder' do
    it 'finds empty seat in row 44, column 2' do
      seats = [
        Seat.new('FBFBBFFLLL'),
        Seat.new('FBFBBFFLLR'),
        # Empty seat: FBFBBFFLLR
        Seat.new('FBFBBFFLRR'),
        Seat.new('FBFBBFFRLL'),
        Seat.new('FBFBBFFRLR'),
        Seat.new('FBFBBFFRRL'),
        Seat.new('FBFBBFFRRR'),
      ]

      expect(EmptySeatFinder.new(seats).find_seat_id).to eq(354)
    end
  end
end