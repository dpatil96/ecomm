# frozen_string_literal: true

class ProductPolicy < ApplicationPolicy
  def create?
    user.present? && user.admin? # Only allow admins to create products
  end

  def update?
    user.present? && user.admin? # Only allow admins to update products
  end

  def destroy?
    user.present? && user.admin? # Only allow admins to delete products
  end

  def edit?
    user.present? && user.admin?
  end
end
