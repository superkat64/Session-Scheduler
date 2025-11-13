class ChangeAppointmentLocationAndStatusToEnums < ActiveRecord::Migration[8.1]
  def change
    # rename old columns so you don’t lose data right away
    rename_column :appointments, :location, :old_location
    rename_column :appointments, :status, :old_status

    # add new integer enum columns
    add_column :appointments, :location, :integer, default: 0, null: false
    add_column :appointments, :status, :integer, default: 0, null: false
  end
end
