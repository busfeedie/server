# frozen_string_literal: true

FactoryBot.define do
  factory :trip, class: '::Trip' do
    gtfs_trip_id { '123-a-5' }
    trip_headsign { 'to City Centre' }
    trip_short_name { 'to City Centre' }
    direction { :inbound }
    block_id { '123' }
    gtfs_shape_id { '123' }
    wheelchair_accessible { :wheelchair_accessible }
    bikes_allowed { :bikes_allowed }
    route { create(:route) }
    calendar { create(:calendar) }
  end
end
