# frozen_string_literal: true

class AddColumnAgeRestrictedToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :age_restricted, :boolean
  end
end
