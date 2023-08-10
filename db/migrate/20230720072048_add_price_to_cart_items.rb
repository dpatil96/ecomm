# frozen_string_literal: true

class AddPriceToCartItems < ActiveRecord::Migration[6.1]
  def change
    add_column :cart_items, :price, :decimal
  end
end
