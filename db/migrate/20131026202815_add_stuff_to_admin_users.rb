class AddStuffToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :name, :string
    add_column :admin_users, :prename, :string
    add_column :admin_users, :title, :string
  end
end
