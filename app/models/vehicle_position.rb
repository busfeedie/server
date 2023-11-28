# frozen_string_literal: true
# typed: strict

# https://gtfs.org/realtime/reference/#message-vehicleposition
class VehiclePosition < ActiveRecord::Base
  extend T::Sig

  @bearing = T.let(nil, T.nilable(Float))
  @odometer = T.let(nil, T.nilable(Float))
  @speed = T.let(nil, T.nilable(Float))
  @measured_at = T.let(nil, T.nilable(DateTime))
  @occupancy_percentage = T.let(nil, T.nilable(Integer))
  @created_at = T.let(nil, T.nilable(DateTime))
  @updated_at = T.let(nil, T.nilable(DateTime))

  belongs_to :trip_identifier, optional: true
  belongs_to :trip, optional: true

  attribute :lonlat, :st_point, srid: 4326, geographic: true
  enum :vehicle_stop_status, %i[incoming_at stopped_at in_transit_to]
  enum :congestion_level, %i[unknown running_smoothly stop_and_go congestion sever_congestion]
end
