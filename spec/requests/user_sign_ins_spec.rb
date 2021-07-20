require 'rails_helper'

RSpec.describe "UserSignIns", type: :request do
  let(:user) { create :user }

  describe "GET /user_sign_ins" do
    it "login with valid information followed by logout" do
      get user_session_path
      post user_session_path, :params => {:user => { :email => user.email, :password => user.password }}
      assert_redirected_to user_profile_path(user.friendly_id)
      follow_redirect!
      assert_template 'users/show'
      assert_select "a[href=?]", sign_in_path, count: 0
      assert_select "a[href=?]", destroy_user_session_path
      delete destroy_user_session_path
      assert_redirected_to root_url
      follow_redirect!
      assert_select "a[href=?]", sign_in_path
      assert_select "a[href=?]", destroy_user_session_path,      count: 0
    end
  end
end
