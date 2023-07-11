class AdminPolicy < ApplicationPolicy
  attr_accessor :admin

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
  def create?
    user.admin? # Only allow admins to create products
  end
end
