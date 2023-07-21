class RemoveDiscountIdFromCartItems < ActiveRecord::Migration[6.1]
  def change
    remove_reference :cart_items, :discount, foreign_key: true
  end
end
