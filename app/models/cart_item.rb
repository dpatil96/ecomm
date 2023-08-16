# frozen_string_literal: true

class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates :price, presence: true
  belongs_to :discount, optional: true
  # validate :check_age_restriction

  # def check_age_restriction
  #   if product.age_restricted? && user&.profile&.age.to_i  < 18
  #     errors.add(:base, "This Product is age restricted.")
  #   end
  # end

  # def check_age_restricion
  #   if product.age_restricted?
  #     user = user.profile.age
  #     if age < 18
  #       errors.add(:base , "This Product is age restricted.")
  #     end
  #   end
  # end
end
