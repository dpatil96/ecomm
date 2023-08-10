# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  def total_price
    total_amount.to_i
  end
end
