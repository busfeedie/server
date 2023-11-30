# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
# https://gtfs.org/schedule/reference/#calendartxt
class CreateCalendar < ActiveRecord::Migration[7.1]
  def change
    create_table :calendars do |t|
      t.string :gtfs_service_id, null: false
      t.boolean :monday, null: false
      t.boolean :tuesday, null: false
      t.boolean :wednesday, null: false
      t.boolean :thursday, null: false
      t.boolean :friday, null: false
      t.boolean :saturday, null: false
      t.boolean :sunday, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.timestamps
    end
    add_reference :trips, :calendar
  end
end
