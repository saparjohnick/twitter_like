class UserPolicy < ApplicationPolicy
  attr_reader :user

  def initialize(user, record)
    @user = user
    @record = record
  end

  def update?
    user.is_admin?
  end

  def destroy?
    user.is_admin?
  end
end
