class AddIsAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :integer
  end
end
