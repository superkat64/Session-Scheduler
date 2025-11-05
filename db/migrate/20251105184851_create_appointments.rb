class CreateAppointments < ActiveRecord::Migration[8.0]
  def change
    create_table :appointments do |t|
      t.references :client, null: false, foreign_key: true
      t.datetime :scheduled_at
      t.string :location
      t.string :status

      t.timestamps
    end
  end
end
