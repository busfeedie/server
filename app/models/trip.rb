# frozen_string_literal: true
# typed: strict

# https://gtfs.org/schedule/reference/#tripstxt
class Trip < ApplicationRecord
  extend T::Sig

  enum direction: %i[outbound inbound]
  enum wheelchair_accessible: %i[wheelchair_accessibility_unknown wheelchair_accessible wheelchair_not_accessible]
  enum bikes_allowed: %i[bikes_unknown bikes_allowed bikes_not_allowed]

  belongs_to :route
  belongs_to :service, polymorphic: true
  belongs_to :shape, optional: true

  validates :route, :service, :gtfs_trip_id, presence: true
  validates :shape, presence: true, if: proc { |trip| trip.route.any_continuous? }

  sig { returns(T::Hash[Symbol, T.untyped]) }
  # rubocop:disable Metrics/MethodLength
  def serialize
    {
      id:,
      gtfs_trip_id:,
      app_id:,
      route_id:,
      service_id:,
      service_type:,
      trip_headsign:,
      trip_short_name:,
      direction:,
      block_id:,
      shape_id:,
      wheelchair_accessible:,
      bikes_allowed:,
      created_at:,
      updated_at:
    }
  end
end
