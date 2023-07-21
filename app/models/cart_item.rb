# frozen_string_literal: true

class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates :price, presence: true
  belongs_to :discount, optional: true
end
