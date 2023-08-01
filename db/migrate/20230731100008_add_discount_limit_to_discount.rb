class AddDiscountLimitToDiscount < ActiveRecord::Migration[6.1]
  def change
    add_column :discounts, :discount_limit, :integer
  end
end
