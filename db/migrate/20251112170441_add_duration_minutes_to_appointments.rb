class AddDurationMinutesToAppointments < ActiveRecord::Migration[8.1]
  def change
    add_column :appointments, :duration_minutes, :integer, null: false, default: 60
  end
end
