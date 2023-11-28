# frozen_string_literal: true

FactoryBot.define do
  factory :trip, class: '::Trip' do
    gtfs_trip_id { '123-a-5' }
    gtfs_route_id { '123' }
    gtfs_service_id { 'a' }
    trip_headsign { 'to City Centre' }
    trip_short_name { 'to City Centre' }
    direction { :inbound }
    block_id { '123' }
    gtfs_shape_id { '123' }
    wheelchair_accessible { :wheelchair_accessible }
    bikes_allowed { :bikes_allowed }
  end
end
