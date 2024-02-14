class MoveShapePoints < ActiveRecord::Migration[7.1]
  def change
    remove_column(:shapes, :lonlat)
    remove_column(:shapes, :shape_pt_sequence)
    remove_column(:shapes, :shape_dist_traveled)
    create_table :shape_points do |t|
      t.references :shape, null: false, foreign_key: true
      t.geography :lonlat, limit: { srid: 4326, type: 'st_point', geographic: true }, null: false
      t.integer :shape_pt_sequence, null: false
      t.float :shape_dist_traveled
      t.timestamps
    end
  end
end
