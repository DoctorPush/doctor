class CreateMedics < ActiveRecord::Migration
  def change
    create_table :medics do |t|
      t.string :name
      t.string :prename
      t.string :title

      t.timestamps
    end
  end
end
