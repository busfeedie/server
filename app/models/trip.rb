# frozen_string_literal: true
# typed: strict

# https://gtfs.org/schedule/reference/#tripstxt
class Trip < ApplicationRecord
  extend T::Sig

  enum direction: %i[outbound inbound]
  enum wheelchair_accessible: %i[wheelchair_accessibility_unknown wheelchair_accessible wheelchair_not_accessible]
  enum bikes_allowed: %i[bikes_unknown bikes_allowed bikes_not_allowed]

  belongs_to :route

  before_validation :refresh_gtfs_route_id

  validates :route, :gtfs_route_id, presence: true

  sig { void }
  def refresh_gtfs_route_id
    self.gtfs_route_id = T.must(route).gtfs_route_id
  end
end
