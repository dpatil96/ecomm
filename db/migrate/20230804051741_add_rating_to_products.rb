class AddRatingToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :rating, :integer
  end
end
