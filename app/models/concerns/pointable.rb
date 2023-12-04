# frozen_string_literal: true

# Support for classes with a lonlat point attribute
module Pointable
  extend ActiveSupport::Concern

  included do
    attribute :lonlat, :st_point, srid: 4326, geographic: true
  end

  def set_lon_lat(lon:, lat:)
    self.lonlat = RGeo::Geographic.spherical_factory(srid: 4326).point(lon, lat)
  end

  def lon
    lonlat.lon
  end

  def lat
    lonlat.lat
  end
end
