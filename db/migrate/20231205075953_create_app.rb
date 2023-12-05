# frozen_string_literal: true

# This represents a particular public transport company and references the objects that belong to it.
class CreateApp < ActiveRecord::Migration[7.1]
  def change
    create_table :apps do |t|
      t.string :name
      t.timestamps
    end
    add_reference :agencies, :app, index: true, null: false
    add_reference :calendars, :app, index: true, null: false
    add_reference :calendar_dates, :app, index: true, null: false
    add_reference :routes, :app, index: true, null: false
    add_reference :shapes, :app, index: true, null: false
    add_reference :stops, :app, index: true, null: false
    add_reference :stop_times, :app, index: true, null: false
    add_reference :trips, :app, index: true, null: false
    add_reference :trip_identifiers, :app, index: true, null: false
    add_reference :vehicle_positions, :app, index: true, null: false
  end
end
