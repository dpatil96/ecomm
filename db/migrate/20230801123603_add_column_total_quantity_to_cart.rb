# frozen_string_literal: true

class AddColumnTotalQuantityToCart < ActiveRecord::Migration[6.1]
  def change
    add_column :carts, :total_quantity, :integer
  end
end
