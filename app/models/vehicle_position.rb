# frozen_string_literal: true
# typed: strict

# https://gtfs.org/realtime/reference/#message-vehicleposition
class VehiclePosition < ApplicationRecord
  extend T::Sig
  include Pointable

  @bearing = T.let(nil, T.nilable(Float))
  @odometer = T.let(nil, T.nilable(Float))
  @speed = T.let(nil, T.nilable(Float))
  @measured_at = T.let(nil, T.nilable(DateTime))
  @occupancy_percentage = T.let(nil, T.nilable(Integer))
  @created_at = T.let(nil, T.nilable(DateTime))
  @updated_at = T.let(nil, T.nilable(DateTime))

  belongs_to :trip_identifier, optional: true
  belongs_to :trip, optional: true
  belongs_to :app
  belongs_to :vehicle, optional: true

  enum :vehicle_stop_status, %i[incoming_at stopped_at in_transit_to]
  enum :congestion_level, %i[unknown running_smoothly stop_and_go congestion sever_congestion]

  validates :lonlat, presence: true

  sig { returns(T::Hash[Symbol, T.untyped]) }
  # rubocop:disable Metrics/MethodLength
  def serialize
    {
      id:,
      lon: lonlat.x,
      lat: lonlat.y,
      bearing:,
      odometer:,
      speed:,
      vehicle_stop_status:,
      measured_at:,
      congestion_level:,
      occupancy_percentage:,
      trip_identifier_id:,
      created_at:,
      updated_at:,
      trip_id:,
      app_id:,
      vehicle_id:
    }
  end
end
