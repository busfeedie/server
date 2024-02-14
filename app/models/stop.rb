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
end
