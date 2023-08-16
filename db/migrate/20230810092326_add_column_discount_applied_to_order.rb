# frozen_string_literal: true

class AddColumnDiscountAppliedToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :discount_applied, :integer
  end
end
