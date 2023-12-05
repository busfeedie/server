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
  belongs_to :shape, optional: true

  validates :route, :calendar, :gtfs_trip_id, presence: true
  validates :shape, presence: true, if: proc { |trip| trip.route.any_continuous? }
end
