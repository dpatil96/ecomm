class AddColumndiscountThresholdToDiscount < ActiveRecord::Migration[6.1]
  def change
    add_column :discounts, :discount_threshold, :integer
  end
end
