class ChangeStopTimeColumnsToInt < ActiveRecord::Migration[7.1]
  def change
    remove_column(:stop_times, :arrival_time)
    remove_column(:stop_times, :departure_time)
    add_column(:stop_times, :arrival_time, :bigint, null: false)
    add_column(:stop_times, :departure_time, :bigint, null: false)
  end
end
