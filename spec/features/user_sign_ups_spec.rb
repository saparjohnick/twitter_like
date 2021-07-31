require 'rails_helper'

RSpec.feature "UsersSignups", type: :feature do
  # let(:user) { create :user }
  describe "GET /sign_up" do
    it 'negative email validation' do
      visit sign_up_url
      expect(page).to have_text 'Sign up'
      fill_in :user_name,	with: "Rspec Name"
      invalid_adresses = %w[user@test,test test.test test.test@test@test.test test@test+test.test]
      invalid_adresses.each do |invalid_address|
        fill_in :user_email,	with: invalid_address 
        fill_in :user_password,	with: "sometext" 
        fill_in :user_password_confirmation,	with: "sometext" 
        click_button :sign_up
        expect(page).to have_text "Email is invalid"
      end
    end

    it 'positive signup' do
      visit sign_up_url
      expect(page).to have_text 'Sign up'
      fill_in :user_name,	with: "Rspec Name"
      fill_in :user_password,	with: "sometext" 
      fill_in :user_password_confirmation,	with: "sometext" 
      fill_in :user_email, with: "test@test.test"
      click_button :sign_up
      expect(page).to have_text "A message with a confirmation link has been sent to your email address. Please follow the link to activate your account."
    end
  end
end
