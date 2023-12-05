class RenameZoneIdOnStops < ActiveRecord::Migration[7.1]
  def change
    rename_column :stops, :zone_id, :gtfs_zone_id
  end
end
