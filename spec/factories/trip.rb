# frozen_string_literal: true

FactoryBot.define do
  factory :trip, class: '::Trip' do
    app { create(:app) }
    gtfs_trip_id { '123' }
    trip_headsign { 'to City Centre' }
    trip_short_name { 'to City Centre' }
    direction { :inbound }
    block_id { '123' }
    wheelchair_accessible { :wheelchair_accessible }
    bikes_allowed { :bikes_allowed }
    route { create(:route) }
    service { create(:calendar) }
  end
end
