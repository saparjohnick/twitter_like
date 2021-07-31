require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user) { create :user }
  let(:micropost) { create :micropost, user_id: user.id }

  describe 'user creation' do
    it 'check validity of post' do
      expect(micropost).to be_valid
    end
  end
end
