require 'rails_helper'

RSpec.describe "UsersSignins", type: :request do
  describe "GET /users_signins" do
    it "works! (now write some real specs)" do
      get new_user_session_path
      expect(response).to have_http_status(200)
    end
  end
end
