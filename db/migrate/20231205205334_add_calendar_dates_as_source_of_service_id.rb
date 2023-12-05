class AddCalendarDatesAsSourceOfServiceId < ActiveRecord::Migration[7.1]
  def change
    add_column :calendar_dates, :gtfs_service_id, :string, null: false
    change_column :calendar_dates, :calendar_id, :bigint, null: true
    remove_column :trips, :calendar_id
    add_column :trips, :service_id, :string, null: false
    add_column :trips, :service_type, :string, null: false
  end
end
