# frozen_string_literal: true
# typed: false

# https://gtfs.org/realtime/reference/#message-vehicleposition
class TripIdentifier < ApplicationRecord
  extend T::Sig

  has_many :vehicle_positions, inverse_of: :trip_identifier

  @start_date = T.let(nil, T.nilable(Date))
  @start_time = T.let(nil, T.nilable(Time))
  @created_at = T.let(nil, T.nilable(DateTime))
  @updated_at = T.let(nil, T.nilable(DateTime))

  attribute :start_time, :time

  sig { returns(String) }
  def start_time_string
    start_time.strftime('%H:%M:%S')
  end
end
