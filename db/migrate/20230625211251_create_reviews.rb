class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :user_name
      t.decimal :rating
      t.text :comments
      

      t.timestamps
    end
  end
end
