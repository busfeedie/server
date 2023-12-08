# frozen_string_literal: true

FactoryBot.define do
  factory :stop, class: '::Stop' do
    app { create(:app) }
    gtfs_stop_id { '123' }
    stop_code { '123' }
    stop_name { 'Stop Name' }
    tts_stop_name { 'Stop Name' }
    stop_desc { 'Stop Description' }
    lonlat { 'POINT(-122.123456 47.123456)' }
    gtfs_zone_id { '123' }
    stop_url { 'https://example.com' }
    location_type { 0 }
    parent_station { nil }
    stop_timezone { 'America/Los_Angeles' }
    wheelchair_boarding { 0 }
    gtfs_level_id { '123' }
    platform_code { '123' }
  end
end
