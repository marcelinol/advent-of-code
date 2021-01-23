require 'rspec'
require './day2_passwords.rb'

class DummyPolicy
  def self.validate(value)
    value == 1
  end
end

describe 'PasswordListValidator' do
  describe '#valid_password_count' do
    context 'validates passwords according to policy' do
      it 'counts the valid passwords' do
        list = [0, 1, 1]
        validator = PasswordListValidator.new(list)

        expect(validator.valid_password_count(DummyPolicy)).to eq(2)
      end
    end
  end
end

describe 'LetterCountPolicy' do
  describe '.validate' do
    context 'when the password must contain the letter a at least 1 time and at most 3 times' do
      it 'password abcde is valid' do
        expect(LetterCountPolicy.validate('1-3 a: abcde')).to be
      end

      it 'password bcdef is not valid' do
        expect(LetterCountPolicy.validate('1-3 a: bcdef')).not_to be
      end
    end
  end
end