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

    describe 'validations' do
      context 'birth year' do
        it 'must have four digits' do
          invalid_data = valid_data
          invalid_data[:byr] = '999'

          expect(PassportValidator.validate(invalid_data)).not_to be
        end

        it 'must be at least 1920' do
          invalid_data = valid_data
          invalid_data[:byr] = '1919'

          expect(PassportValidator.validate(invalid_data)).not_to be
        end

        it 'must be at most 2002' do
          invalid_data = valid_data
          invalid_data[:byr] = '2003'

          expect(PassportValidator.validate(invalid_data)).not_to be
        end
      end

      context 'issue year' do
        it 'must have four digits' do
          invalid_data = valid_data
          invalid_data[:iyr] = '999'

          expect(PassportValidator.validate(invalid_data)).not_to be
        end

        it 'must be at least 2010' do
          invalid_data = valid_data
          invalid_data[:byr] = '2009'

          expect(PassportValidator.validate(invalid_data)).not_to be
        end

        it 'must be at most 2020' do
          invalid_data = valid_data
          invalid_data[:byr] = '2021'

          expect(PassportValidator.validate(invalid_data)).not_to be
        end
      end

      context 'expiration year' do
        it 'must have four digits' do
          invalid_data = valid_data
          invalid_data[:eyr] = '999'

          expect(PassportValidator.validate(invalid_data)).not_to be
        end

        it 'must be at least 2020' do
          invalid_data = valid_data
          invalid_data[:byr] = '2019'

          expect(PassportValidator.validate(invalid_data)).not_to be
        end

        it 'must be at most 2030' do
          invalid_data = valid_data
          invalid_data[:byr] = '2031'

          expect(PassportValidator.validate(invalid_data)).not_to be
        end
      end

      context 'height' do
        # hgt (Height) - a number followed by either cm or in:
        #   If cm, the number must be at least 150 and at most 193.
        #   If in, the number must be at least 59 and at most 76

        # This could definitely be tested more extensively
        # or it could be enforced by design - like using `Height.new(159, :cm)`
        it 'must be an integer followed by either cm or in' do
          invalid_data = valid_data
          invalid_data[:hgt] = '1.5ft'

          expect(PassportValidator.validate(invalid_data)).not_to be
        end

        it "must be at least 150cm" do
          invalid_data = valid_data
          invalid_data[:hgt] = '149cm'

          expect(PassportValidator.validate(invalid_data)).not_to be
        end

        it "must be at most 193cm" do
          invalid_data = valid_data
          invalid_data[:hgt] = '194cm'

          expect(PassportValidator.validate(invalid_data)).not_to be
        end

        it "must be at least 59in" do
          invalid_data = valid_data
          invalid_data[:hgt] = '58in'

          expect(PassportValidator.validate(invalid_data)).not_to be
        end

        it "must be at most 76in" do
          invalid_data = valid_data
          invalid_data[:hgt] = '77in'

          expect(PassportValidator.validate(invalid_data)).not_to be
        end
      end

      context 'hair colour' do
        it 'must be a # followed by exactly six characters 0-9 or a-f' do
          invalid_data = valid_data
          invalid_data[:hcl] = 'xunda'

          expect(PassportValidator.validate(invalid_data)).not_to be
        end
      end

      context 'eye colour' do
        it 'must be one of: amb blu brn gry grn hzl oth' do
          invalid_data = valid_data
          invalid_data[:ecl] = 'amarelo queimado'

          expect(PassportValidator.validate(invalid_data)).not_to be
        end
      end

      context 'passport id' do
        it "must be a nine-digit number, including leading zeroes" do
          invalid_data = valid_data
          invalid_data[:pid] = '12345678'

          expect(PassportValidator.validate(invalid_data)).not_to be
        end
      end
    end
  end
end