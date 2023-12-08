# frozen_string_literal: true
# typed: false

RSpec.describe VehiclePosition, type: :model do
  let(:app) { create(:app) }
  context 'when creating a new position' do
    it 'should create a new position from a string' do
      expect do
        position = ::VehiclePosition.create!(app:, lonlat: 'POINT(-122.345 47.621)')
        expect(position.lonlat.lon).to eq(-122.345)
        expect(position.lonlat.lat).to eq(47.621)
      end.to change { ::VehiclePosition.count }.by(1)
    end

    it 'should create a new position from a point' do
      point = RGeo::Geographic.spherical_factory(srid: 4326).point(-122.345, 47.621)
      expect do
        position = ::VehiclePosition.create!(app:, lonlat: point)
        expect(position.lonlat.lon).to eq(-122.345)
        expect(position.lonlat.lat).to eq(47.621)
      end.to change { ::VehiclePosition.count }.by(1)
    end

    it 'can be linked with a trip' do
      trip = create(:trip)
      point = RGeo::Geographic.spherical_factory(srid: 4326).point(-122.345, 47.621)
      position = nil
      expect do
        position = ::VehiclePosition.create!(app:, trip:, lonlat: point)
      end.to change { ::VehiclePosition.count }.by(1)
      expect(position.trip).to eq(trip)
    end
  end
end
