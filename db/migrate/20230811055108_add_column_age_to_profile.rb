class AddColumnAgeToProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :age, :integer
  end
end
