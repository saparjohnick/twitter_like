class MicropostSearchPolicy < ApplicationPolicy
  attr_reader :user, :micropost

  def initialize(user, micropost)
    @user = user
    @micropost = micropost
  end

  def index?
    user.is_admin?
  end

end
