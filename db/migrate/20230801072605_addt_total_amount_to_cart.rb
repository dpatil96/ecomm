# frozen_string_literal: true

class AddtTotalAmountToCart < ActiveRecord::Migration[6.1]
  def change
    add_column :carts, :total_amount, :integer
  end
end
