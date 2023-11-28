# frozen_string_literal: true
# typed: strict

# https://gtfs.org/schedule/reference/#routestxt
class Route < ApplicationRecord
  extend T::Sig

  enum route_type: %i[tram metro rail bus ferry cable_tram cable_car funicular trolleybus monorail]
  enum continuous_pickup: %i[continuous_pickup_normal continuous_pickup_not_available continuous_pickup_must_phone
                             continuous_pickup_must_coordiante]
  enum continuous_drop_off: %i[continuous_drop_off_normal continuous_drop_off_not_available
                               continuous_drop_off_must_phone continuous_drop_off_must_coordiante]

  validates :gtfs_route_id, :route_type, :gtfs_agency_id, presence: true
  validates :route_short_name, presence: true, if: proc { |route| route.route_long_name.blank? }
  validates :route_long_name, presence: true, if: proc { |route| route.route_short_name.blank? }
  validates :route_short_name, :route_long_name, length: { maximum: 255 }
  validates :route_desc, length: { maximum: 255 }
  validates :route_url, length: { maximum: 255 }
  validates :route_color, length: { maximum: 6 }
  validates :route_text_color, length: { maximum: 6 }
  validates :route_sort_order, numericality: { only_integer: true }, allow_nil: true

  has_many :trips, inverse_of: :route
end
