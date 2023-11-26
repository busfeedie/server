# frozen_string_literal: true

# Adds the initial trip identifier table
class CreateTripIdentifier < ActiveRecord::Migration[7.1]
  def change
    create_table :trip_identifiers do |t|
      t.date :start_date
      t.time :start_time
      t.timestamps
    end
  end
end
