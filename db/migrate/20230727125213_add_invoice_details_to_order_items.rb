class AddInvoiceDetailsToOrderItems < ActiveRecord::Migration[6.1]
  def change
    add_column :order_items, :invoice_status, :string
    add_column :order_items, :invoice_date, :date
  end
end
