require 'rails_helper'

RSpec.describe "DeleteUsers", type: :request do
  let(:user) { create :user }
  let(:admin) { create :admin }
  describe "DELETE /users/:id(.:format) " do
    it "deletes user" do
      post user_session_url, :params => {:admin => { :email => user.email, :password => user.password }}
      delete user_destroy_url(user.id)
      assert_redirected_to root_url
      follow_redirect!
      assert_template 'static_pages/home'
      assert_select '.alert', 'User succesfully deleted.'
    end
  end
end
