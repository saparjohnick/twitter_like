require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, name: 'Test', email: 'test@test.test') }

  describe 'user creation' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
      # expect(User.new(name: "Test User", email:"test@test.test")).to be_valid
    end

    it 'name should not be too long' do
      user.name = 'a' * 51
      expect(user).not_to be_valid
    end

    it 'email should not be too long' do
      user.email = 'a' * 256 + '@test.test'
      expect(user).not_to be_valid
    end

    it 'email validation should reject invalid email test' do
      invalid_adresses = %w[user@test,test test.test test.test@test@test.test test@test+test.test]
      invalid_adresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).not_to be_valid
      end
    end

    it 'email address should be unique' do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save
      expect(duplicate_user).not_to be_valid
    end

    it 'email address should not be blank' do
      user.password = user.password_confirmation = ' ' * 6
      expect(user).not_to be_valid
    end

    it 'email address should not be less then 6' do
      user.password = user.password_confirmation = 'a' * 5
      expect(user).not_to be_valid
    end
  end
end
