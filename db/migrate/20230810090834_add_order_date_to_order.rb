class AddOrderDateToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :order_date, :date
  end
end
