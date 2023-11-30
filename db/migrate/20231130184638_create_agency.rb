# frozen_string_literal: true

# Adds the agency table to the database.
class CreateAgency < ActiveRecord::Migration[7.1]
  def change
    create_table :agencies do |t|
      t.string :gtfs_agency_id, null: false
      t.string :agency_name, null: false
      t.string :agency_url, null: false
      t.string :agency_timezone, null: false
      t.string :agency_lang
      t.string :agency_phone
      t.string :agency_fare_url
      t.string :agency_email
      t.timestamps
    end
  end
end
