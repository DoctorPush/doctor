class AddAddressToMedics < ActiveRecord::Migration
  def change
    add_column :medics, :address, :string
  end
end
