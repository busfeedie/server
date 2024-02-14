class AddAppToShapePoints < ActiveRecord::Migration[7.1]
  def change
    add_reference :shape_points, :app, index: true, null: false
  end
end
