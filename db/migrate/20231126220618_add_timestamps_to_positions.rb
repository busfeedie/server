# frozen_string_literal: true

# Add timestamps to vehicle_positions table
class AddTimestampsToPositions < ActiveRecord::Migration[7.1]
  def change
    add_timestamps :vehicle_positions, null: false, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
