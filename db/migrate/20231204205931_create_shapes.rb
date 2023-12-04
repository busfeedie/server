# frozen_string_literal: true

# https://gtfs.org/schedule/reference/#shapestxt
class CreateShapes < ActiveRecord::Migration[7.1]
  def change
    create_table :shapes do |t|
      t.string :gtfs_shape_id, null: false
      t.geography 'lonlat', limit: { srid: 4326, type: 'st_point', geographic: true }, null: false
      t.integer :shape_pt_sequence, null: false
      t.float :shape_dist_traveled
      t.timestamps
    end
    add_reference :trips, :shape, foreign_key: true
  end
end
