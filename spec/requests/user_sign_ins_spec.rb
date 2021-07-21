require 'rails_helper'

RSpec.describe "UserSignIns", type: :request do
  let(:user) { create :user }

  describe "GET /user_sign_ins" do
    it "login with valid information followed by logout" do
      get user_session_url
      post user_session_url, :params => {:user => { :email => user.email, :password => user.password }}
      assert_redirected_to user_profile_url(user.friendly_id)
      follow_redirect!
      assert_template 'users/show'
      assert_select "a[href=?]", sign_in_url, count: 0
      assert_select "a[href=?]", destroy_user_session_url
      delete destroy_user_session_url
      assert_redirected_to root_url
      follow_redirect!
      assert_select "a[href=?]", sign_in_url
      assert_select "a[href=?]", destroy_user_session_url,      count: 0
    end
  end
end
