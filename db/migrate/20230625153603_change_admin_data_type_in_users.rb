class ChangeAdminDataTypeInUsers < ActiveRecord::Migration[6.1]
  def change
    def up
      change_column :users, :admin, :string
    end
  
    def down
      change_column :users, :admin, :boolean
    end
  end
end
