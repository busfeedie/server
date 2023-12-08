# frozen_string_literal: true

FactoryBot.define do
  factory :route, class: '::Route' do
    app { create(:app) }
    gtfs_route_id { '123-a-5' }
    agency { create(:agency) }
    route_short_name { '123' }
    route_long_name { 'to City Centre' }
    route_desc { 'to City Centre' }
    route_type { :bus }
    route_url { 'https://example.com' }
    route_color { 'ffffff' }
    route_text_color { '000000' }
    route_sort_order { 1 }
  end
end
