# frozen_string_literal: true
# typed: strict

# https://gtfs.org/schedule/reference/#tripstxt
class Trip < ApplicationRecord
  extend T::Sig

  enum direction: %i[outbound inbound]
  enum wheelchair_accessible: %i[wheelchair_accessibility_unknown wheelchair_accessible wheelchair_not_accessible]
  enum bikes_allowed: %i[bikes_unknown bikes_allowed bikes_not_allowed]

  belongs_to :route
  belongs_to :calendar

  before_validation :refresh_gtfs_route_id, :refresh_gtfs_service_id

  validates :route, :gtfs_route_id, :gtfs_trip_id, :calendar, :gtfs_service_id, presence: true
  validates :gtfs_shape_id, presence: true, if: proc { |trip| !trip.route.any_continuous? }

  sig { void }
  def refresh_gtfs_route_id
    self.gtfs_route_id = T.must(route).gtfs_route_id
  end

  sig { void }
  def refresh_gtfs_service_id
    self.gtfs_service_id = T.must(calendar).gtfs_service_id
  end
end
