class AddFieldsToProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :address, :string
    add_column :profiles, :gender, :string
    add_column :profiles, :birth_date, :date
  end
end
