# frozen_string_literal: true

FactoryBot.define do
  factory :trip, class: '::Trip' do
    trip_headsign { 'to City Centre' }
    trip_short_name { 'to City Centre' }
    direction { :inbound }
    block_id { '123' }
    wheelchair_accessible { :wheelchair_accessible }
    bikes_allowed { :bikes_allowed }
    route { create(:route) }
    calendar { create(:calendar) }
  end
end
