require 'rails_helper'

RSpec.feature "UserSignIns", type: :feature do
  let(:user) { create :user }
  describe "sign_in" do
    it 'negative sign in' do
      visit sign_in_path
      expect(page).to have_text 'Sign in'
      invalid_adresses = %w[user@test,test test.test test.test@test@test.test test@test+test.test]
      invalid_adresses.each do |invalid_address|
        fill_in :user_email,	with: invalid_address 
        fill_in :user_password,	with: "sometext" 
        click_button :sign_in
        expect(page).to have_text "Invalid Email or password."
      end
    end

    it 'positive sign in and sign out' do
      visit sign_in_path
      expect(page).to have_text 'Sign in'
      fill_in :user_email, with: user.email
      fill_in :user_password,	with: user.password 
      click_button :sign_in
      expect(page).to have_text "Signed in successfully."
      # click_link :dropdown_link
      # expect(page).to have_selector "#sign_out_link", visible: true
      # click_link :sign_out_link
      # expect(page).to have_text "Signed out successfully"
    end
  end
end
