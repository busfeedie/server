# frozen_string_literal: true
# typed: false

RSpec.describe ::Stop, type: :model do
  let(:app) { create(:app) }
  context 'when creating a new Stop' do
    it 'should create a new Stop with all attributes populated' do
      parent_station = create(:stop)
      expect do
        ::Stop.create!(
          app:,
          gtfs_stop_id: '123',
          stop_code: '123',
          stop_name: 'Stop Name',
          tts_stop_name: 'Stop Name',
          stop_desc: 'Stop Description',
          lonlat: 'POINT(-122.123456 47.123456)',
          gtfs_zone_id: '123',
          stop_url: 'https://example.com',
          location_type: :stop,
          parent_station:,
          stop_timezone: 'America/Los_Angeles',
          wheelchair_boarding: 0,
          gtfs_level_id: '123',
          platform_code: '123'
        )
      end.to change { ::Stop.count }.by(1)
    end
    it 'stop name is not required for boarding area' do
      expect do
        ::Stop.create!(
          app:,
          gtfs_stop_id: '123',
          stop_name: 'Stop Name',
          location_type: :generic_node
        )
      end.to change { ::Stop.count }.by(1)
    end
  end
end
