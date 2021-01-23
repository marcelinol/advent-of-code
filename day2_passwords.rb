# --- Day 2: Password Philosophy ---
#
# Your flight departs in a few days from the coastal airport; the easiest way down to the coast from here is via toboggan.
#
#   The shopkeeper at the North Pole Toboggan Rental Shop is having a bad day. "Something's wrong with our computers; we can't log in!" You ask if you can take a look.
#
#   Their password database seems to be a little corrupted: some of the passwords wouldn't have been allowed by the Official Toboggan Corporate Policy that was in effect when they were chosen.
#
# To try to debug the problem, they have created a list (your puzzle input) of passwords (according to the corrupted database) and the corporate policy when that password was set.
#
# For example, suppose you have the following list:
#
# 1-3 a: abcde
# 1-3 b: cdefg
# 2-9 c: ccccccccc
# Each line gives the password policy and then the password. The password policy indicates the lowest and highest number of times a given letter must appear for the password to be valid. For example, 1-3 a means that the password must contain a at least 1 time and at most 3 times.
#
# In the above example, 2 passwords are valid. The middle password, cdefg, is not; it contains no instances of b, but needs at least 1. The first and third passwords are valid: they contain one a or nine c, both within the limits of their respective policies.
#
# How many passwords are valid according to their policies?

class PasswordListValidator
  def initialize(password_list)
    @list = password_list
  end

  def valid_password_count(policy)
    valid_passwords = 0

    # line looks like this: "4-7 h: hhxhzmwhhhh\n"
    @list.each do |line|
      valid_passwords += 1 if policy.validate(line)
    end

    valid_passwords
  end
end

class LetterCountPolicy
  def self.validate(line)
    # this regex extracts the values from policy "1-3 a: abcde" as: minimum 1, maximum 3, character a and password abcde
    minimum, maximum, character, password = /(\d*)-(\d*)\s(\w):\s(\w*)/.match(line).captures
    minimum = minimum.to_i
    maximum = maximum.to_i

    password.split('').find_all { |char| char == character }.size.between?(minimum, maximum)
  end
end

# official_input = File.open("day2_input.txt")
# puts PasswordListValidator.new(official_input).valid_password_count(LetterCountPolicy)