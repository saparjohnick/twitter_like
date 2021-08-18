class MicropostPolicy < ApplicationPolicy
  attr_reader :user, :micropost

  def initialize(user, micropost)
    @user = user
    @micropost = micropost
  end

  def update?
    user.is_admin?
  end

  def destroy?
    user.is_admin?
  end
end
