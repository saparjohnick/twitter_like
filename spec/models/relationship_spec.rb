require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let!(:another_user) { create :user }
  let!(:user) { create :user, :with_relationship, followed_id: another_user.id }
  
  @relationship = Relationship.last
  it { expect(user.active_relationships.last).to be_valid }
end
