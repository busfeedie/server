class AddDefaultsToStops < ActiveRecord::Migration[7.1]
  def change
    change_column_default :stops, :location_type, from: nil, to: 0
    change_column_default :stops, :wheelchair_boarding, from: nil, to: 0
  end
end
