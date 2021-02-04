require 'dry-validation'

class InputParser
  def self.parse(input)
    parsed = []
    one_passport_info = []
    input.each_with_index do |item, index|
      if item == "\n"
        parsed_info = parse_one_passport_info(one_passport_info)
        parsed << parsed_info

        one_passport_info = []
        next
      end
      one_passport_info << item
    end

    parsed_info = parse_one_passport_info(one_passport_info)
    parsed << parsed_info

    parsed
  end

  private

  def self.parse_one_passport_info(one_passport_info)
    # This is to make ["a:1 b:2", "c:3"] to become ["a:1", "b:2", "c:3"]
    one_passport_info = one_passport_info.join(' ').split(' ').map(&:chomp)
    parsed_info = {}
    one_passport_info.each do |info|
      # Why didn't this work to get all groups with regex?? https://rubular.com/r/ESNUp4oVPAdCsM
      /(?<key>\w*):(?<value>\S*)/ =~ info
      parsed_info[key.to_sym] = value
    end

    parsed_info
  end
end

class Passport < Dry::Validation::Contract
  params do
    required(:eyr).filled(:string) # Expiration Year
    required(:iyr).filled(:string) # Issue Year
    required(:hcl).filled(:string) # Hair Color
    required(:byr).filled(:string) # Birth Year
    required(:ecl).filled(:string) # Eye Color
    required(:hgt).filled(:string) # Height
    required(:pid).filled(:string) # Passport ID
    optional(:cid).value(:string) # Country ID
  end

  rule(:byr) do
    key.failure('must have four digits') unless value.size == 4
    key.failure('must be between 1920 and 2002') unless value.to_i.between?(1920, 2002)
  end

  rule(:iyr) do
    key.failure('must have four digits') unless value.size == 4
    key.failure('must be between 2010 and 2020') unless value.to_i.between?(2010, 2020)
  end

  rule(:eyr) do
    key.failure('must have four digits') unless value.size == 4
    key.failure('must be between 2020 and 2030') unless value.to_i.between?(2020, 2030)
  end

  rule(:hgt) do
    key.failure('must be an integer followed by either cm or in') unless value.match(/^\d*(cm|in)$/)
    if value.match(/cm/)
      key.failure('must be between 150 and 193 cm') unless value[/\d*/].to_i.between?(150, 193)
    else
      key.failure('must be between 59 and 76 in') unless value[/\d*/].to_i.between?(59, 76)
    end
  end

  rule(:hcl) do
    key.failure('must be a # followed by exactly six characters 0-9 or a-f') unless value.match(/^#([0-9]|[a-f]){6}$/)
  end

  rule(:pid) do
    key.failure('must be a nine-digit number, including leading zeroes') unless value.size == 9
  end

  rule(:ecl) do
    key.failure('must be one of: amb blu brn gry grn hzl oth') unless %w[amb blu brn gry grn hzl oth].include?(value)
  end
end

class PassportValidator
  def self.validate(passport_data)
    Passport.new.call(passport_data).success?
  end
end

official_input = File.open("day_4/day4_input.txt")
valid_passports = 0
InputParser.parse(official_input).each do |passport_data|
  valid_passports += 1 if PassportValidator.validate(passport_data)
end
puts "valid passports: #{valid_passports}"

# --- Day 4: Passport Processing ---
# You arrive at the airport only to realize that you grabbed your North Pole Credentials instead of your passport. While these documents are extremely similar, North Pole Credentials aren't issued by a country and therefore aren't actually valid documentation for travel in most of the world.
#
#   It seems like you're not the only one having problems, though; a very long line has formed for the automatic passport scanners, and the delay could upset your travel itinerary.
#
# Due to some questionable network security, you realize you might be able to solve both of these problems at the same time.
#
# The automatic passport scanners are slow because they're having trouble detecting which passports have all required fields. The expected fields are as follows:
#
# byr (Birth Year)
# iyr (Issue Year)
# eyr (Expiration Year)
# hgt (Height)
# hcl (Hair Color)
# ecl (Eye Color)
# pid (Passport ID)
# cid (Country ID)
# Passport data is validated in batch files (your puzzle input). Each passport is represented as a sequence of key:value pairs separated by spaces or newlines. Passports are separated by blank lines.
#
#   Here is an example batch file containing four passports:
#
#   ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
#   byr:1937 iyr:2017 cid:147 hgt:183cm
#
#   iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
#   hcl:#cfa07d byr:1929
#
#   hcl:#ae17e1 iyr:2013
#   eyr:2024
#   ecl:brn pid:760753108 byr:1931
#   hgt:179cm
#
#  hcl:#cfa07d eyr:2025 pid:166559648
#   iyr:2011 ecl:brn hgt:59in
#
# The first passport is valid - all eight fields are present. The second passport is invalid - it is missing hgt (the Height field).
#
#   The third passport is interesting; the only missing field is cid, so it looks like data from North Pole Credentials, not a passport at all! Surely, nobody would mind if you made the system temporarily ignore missing cid fields. Treat this "passport" as valid.
#
#   The fourth passport is missing two fields, cid and byr. Missing cid is fine, but missing any other field is not, so this passport is invalid.
#
#   According to the above rules, your improved system would report 2 valid passports.
#
#   Count the number of valid passports - those that have all required fields. Treat cid as optional. In your batch file, how many passports are valid?

