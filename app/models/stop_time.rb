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
end
