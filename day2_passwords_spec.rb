require 'rspec'
require './day2_passwords.rb'

describe 'PasswordValidator' do
  context 'validates password according to policy' do
    context 'when the password must contain the letter a at least 1 time and at most 3 times' do
      it 'password abcde is valid' do
        expect(PasswordValidator.validate(policy: '1-3 a', password: 'abcde')).to be
      end

      it 'password bcdef is not valid' do
        expect(PasswordValidator.validate(policy: '1-3 a', password: 'bcdef')).not_to be
      end
    end
  end
end