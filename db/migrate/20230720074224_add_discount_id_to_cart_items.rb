class AddDiscountIdToCartItems < ActiveRecord::Migration[6.1]
  def change
    add_reference :cart_items, :discount, foreign_key: true
  end
end
