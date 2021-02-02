require 'rspec'
require_relative 'day4_passport_validator'

# eyr:2029 iyr:2013
# hcl:#ceb3a1 byr:1939 ecl:blu
#   hgt:163cm
# pid:660456119
#
# hcl:#0f8b2e ecl:grn
#   byr:1975 iyr:2011
# eyr:2028 cid:207 hgt:158cm
# pid:755567813



describe 'Day 4' do
  describe 'InputParser' do
    let(:input) { File.open('day_4/day4_input_fixture.txt') }

    it 'splits data on white space and new line' do
      expect(InputParser.parse(input)).to eq(
        [
          {
            eyr: '2029',
            iyr: '2013',
            hcl: '#ceb3a1',
            byr: '1939',
            ecl: 'blu',
            hgt: '163cm',
            pid: '660456119'
          },
          {
            hcl: '#0f8b2e',
            ecl: 'grn',
            byr: '1975',
            iyr: '2011',
            eyr: '2028',
            cid: '207',
            hgt: '158cm',
            pid: '755567813'
          }
        ]
      )
    end
  end

  describe 'PassportValidator' do
    let(:valid_data) {
      {
        eyr: '2020',
        iyr: '2017',
        ecl: 'gry',
        pid: '860033327',
        hcl: '#fffffd',
        byr: '1937',
        cid: '147',
        hgt: '183cm'
      }
    }

    it 'validates a valid passport' do
      expect(PassportValidator.validate(valid_data)).to be
    end

    it 'validates an invalid passport' do
      passport_info = valid_data.delete(:eyl)

      expect(PassportValidator.validate(passport_info)).not_to be
    end

  end
end