# frozen_string_literal: true

FactoryBot.define do
  factory :shape, class: '::Shape' do
    app { create(:app) }
    gtfs_shape_id { '123' }
    lonlat { 'POINT(-122.123456 47.123456)' }
    shape_pt_sequence { 1 }
    shape_dist_traveled { 1.0 }
  end
end
