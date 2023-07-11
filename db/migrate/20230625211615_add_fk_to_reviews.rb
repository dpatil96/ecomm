class AddFkToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :product_id, :intger
  end
end
