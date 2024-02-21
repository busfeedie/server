# frozen_string_literal: true
# typed: strict

# https://gtfs.org/schedule/reference/#stopstxt
class Stop < ApplicationRecord
  extend T::Sig
  include Pointable

  enum location_type: %i[stop station entrance generic_node boarding_area]
  enum wheelchair_boarding: %i[unknown accessible not_accessible]
  has_many :child_stops, class_name: 'Stop', foreign_key: 'parent_station_id', dependent: :destroy
  belongs_to :parent_station, class_name: 'Stop', optional: true
  has_many :stop_times, inverse_of: :stop, dependent: :destroy

  validates :gtfs_stop_id, presence: true
  validates :stop_name, :lonlat, presence: true, if: proc { |stop|
                                                       %i[generic_node boarding_area].include? stop.location_type
                                                     }

  sig { returns(T::Hash[Symbol, T.untyped]) }
  def serialize
    {
      id:,
      app_id:,
      gtfs_stop_id:,
      stop_code:,
      stop_name:,
      tts_stop_name:,
      stop_desc:,
      lon:,
      lat:,
      gtfs_zone_id:,
      stop_url:,
      location_type:,
      parent_station_id:,
      stop_timezone:,
      wheelchair_boarding:,
      gtfs_level_id:,
      platform_code:,
      created_at:,
      updated_at:
    }
  end
end
