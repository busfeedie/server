# frozen_string_literal: true
# typed: strict

# https://gtfs.org/schedule/reference/#routestxt
class Route < ApplicationRecord
  extend T::Sig

  enum route_type: %i[tram metro rail bus ferry cable_tram cable_car funicular trolleybus monorail]
  enum continuous_pickup: %i[continuous none phone coordinate], _prefix: :continuous_pickup
  enum continuous_drop_off: %i[continuous none phone coordinate], _prefix: :continuous_drop_off

  has_many :trips, inverse_of: :route
  belongs_to :agency

  before_validation :refresh_gtfs_agency_id

  validates :gtfs_route_id, :route_type, :gtfs_agency_id, :agency, presence: true
  validates :route_short_name, presence: true, if: proc { |route| route.route_long_name.blank? }
  validates :route_long_name, presence: true, if: proc { |route| route.route_short_name.blank? }
  validates :route_short_name, :route_long_name, length: { maximum: 255 }
  validates :route_desc, length: { maximum: 255 }
  validates :route_url, length: { maximum: 255 }
  validates :route_color, length: { maximum: 6 }
  validates :route_text_color, length: { maximum: 6 }
  validates :route_sort_order, numericality: { only_integer: true }, allow_nil: true

  sig { returns(T::Boolean) }
  def any_continuous?
    continuous_drop_off_available? || continuous_pickup_available?
  end

  sig { returns(T::Boolean) }
  def continuous_pickup_available?
    !continuous_pickup_none?
  end

  sig { returns(T::Boolean) }
  def continuous_drop_off_available?
    !continuous_drop_off_none?
  end

  sig { void }
  def refresh_gtfs_route_id
    self.gtfs_agency_id = T.must(agency).gtfs_agency_id
  end

  sig { void }
  def refresh_gtfs_agency_id
    self.gtfs_agency_id = T.must(agency).gtfs_agency_id
  end
end
