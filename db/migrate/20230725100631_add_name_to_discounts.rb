# frozen_string_literal: true

class AddNameToDiscounts < ActiveRecord::Migration[6.1]
  def change
    add_column :discounts, :name, :string
  end
end
