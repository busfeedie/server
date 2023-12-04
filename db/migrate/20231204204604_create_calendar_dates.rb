# frozen_string_literal: true

# https://gtfs.org/schedule/reference/#calendar_datestxt
class CreateCalendarDates < ActiveRecord::Migration[7.1]
  def change
    create_table :calendar_dates do |t|
      t.references :calendar, null: false, foreign_key: true
      t.date :date, null: false
      t.integer :exception_type, null: false
      t.timestamps
    end
  end
end
