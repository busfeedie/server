# frozen_string_literal: true

FactoryBot.define do
  factory :vehicle_position, class: '::VehiclePosition' do
    app { create(:app) }
    trip { create(:trip, app:) }
    vehicle { create(:vehicle, app:) }
    lonlat { RGeo::Geographic.spherical_factory(srid: 4326).point(-122.345, 47.621) }
  end
end
