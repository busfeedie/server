# frozen_string_literal: true

FactoryBot.define do
  factory :stop_time, class: '::StopTime' do
    app { create(:app) }
    trip { create(:trip, app:) }
    stop { create(:stop, app:) }
    stop_sequence { '1' }
    arrival_time { '04:30:00' }
    departure_time { '04:31:00' }
    stop_headsign { "O'Connell Street, Dublin City" }
    pickup_type { :regular }
    drop_off_type { :regular }
    timepoint { true }
  end
end
