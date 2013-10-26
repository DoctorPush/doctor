class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :name
      t.string :prename
      t.string :title
      t.string :record_id
      t.string :address
      t.string :tel_number

      t.timestamps
    end
  end
end
