# frozen_string_literal: true

FactoryBot.define do
  factory :calendar, class: '::Calendar' do
    app { create(:app) }
    gtfs_service_id { '123-1-1' }
    start_date { '2020-11-14' }
    end_date { '2023-11-15' }
    monday { true }
    tuesday { true }
    wednesday { true }
    thursday { true }
    friday { true }
    saturday { true }
    sunday { true }
  end
end
