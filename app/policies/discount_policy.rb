# frozen_string_literal: true

# app/policies/discount_policy.rb
class DiscountPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def create?
    user.present? && user.admin? # Only admin users can create discounts
  end

  def update?
    user.present? && user.admin? # Only admin users can update discounts
  end

  def destroy?
    user.present? && user.admin? # Only admin users can delete discounts
  end
end
