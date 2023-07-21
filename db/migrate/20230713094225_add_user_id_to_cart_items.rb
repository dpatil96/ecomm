# frozen_string_literal: true

class AddUserIdToCartItems < ActiveRecord::Migration[6.1]
  def change
    add_reference :cart_items, :user, foreign_key: true
  end
end
