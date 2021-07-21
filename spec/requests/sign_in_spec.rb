require 'rails_helper'
# copypaste from https://github.com/heartcombo/devise/wiki/How-To:-Test-controllers-with-Rails-%28and-RSpec%29
RSpec.describe "SignIns", type: :request do
  let(:user) {create :user}
  def sign_in_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in user
    end
  end
end
