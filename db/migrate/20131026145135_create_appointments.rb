class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.datetime :start
      t.datetime :end
      t.references :patient, index: true
      t.references :medic, index: true

      t.timestamps
    end
  end
end
