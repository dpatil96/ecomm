# app/policies/product_policy.rb
class ProductPolicy < ApplicationPolicy
  
    def create?
      user.admin? # Only allow admins to create products
    end
  
    def update?
      user.admin? # Only allow admins to update products
    end
  
    def destroy?
      user.admin? # Only allow admins to delete products
    end
    
    def edit?
      user.admin?
    end
  
    def destroy?
      user.admin?
    end
  end
  