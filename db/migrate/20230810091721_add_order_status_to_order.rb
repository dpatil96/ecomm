class AddOrderStatusToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :order_status, :string
  end
end
