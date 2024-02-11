# frozen_string_literal: true
# typed: strict

# https://gtfs.org/schedule/reference/#stop_timestxt
class StopTime < ApplicationRecord
  extend T::Sig

  enum pickup_type: %i[regular none phone coordinate], _prefix: :pickup
  enum drop_off_type: %i[regular none phone coordinate], _prefix: :drop_off
  enum continuous_pickup: %i[continuous none phone coordinate], _prefix: :continuous_pickup
  enum continuous_drop_off: %i[continuous none phone coordinate], _prefix: :continuous_drop_off

  belongs_to :trip
  belongs_to :stop

  validates :trip, :stop, :stop_sequence, presence: true
  validates :arrival_time, :departure_time, presence: true, if: proc { |stop_time| stop_time.timepoint }

  sig { returns(T::Hash[Symbol, T.untyped]) }
  # rubocop:disable Metrics/MethodLength
  def serialize
    {
      id:,
      app_id:,
      trip_id:,
      stop_id:,
      arrival_time:,
      departure_time:,
      stop_sequence:,
      stop_headsign:,
      pickup_type:,
      drop_off_type:,
      continuous_pickup:,
      continuous_drop_off:,
      shape_dist_traveled:,
      timepoint:,
      created_at:,
      updated_at:
    }
  end
end
