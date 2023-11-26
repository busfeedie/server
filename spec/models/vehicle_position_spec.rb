# frozen_string_literal: true
# typed: false

RSpec.describe VehiclePosition, type: :model do
  context 'when creating a new position' do
    it 'should create a new position from a string' do
      expect do
        position = ::VehiclePosition.create!(lonlat: 'POINT(-122.345 47.621)')
        expect(position.lonlat.x).to eq(-122.345)
        expect(position.lonlat.y).to eq(47.621)
      end.to change { ::VehiclePosition.count }.by(1)
    end

    it 'should create a new position from a point' do
      point = RGeo::Geographic.spherical_factory(srid: 4326).point(-122.345, 47.621)
      expect do
        position = ::VehiclePosition.create!(lonlat: point)
        expect(position.lonlat.x).to eq(-122.345)
        expect(position.lonlat.y).to eq(47.621)
      end.to change { ::VehiclePosition.count }.by(1)
    end
  end
end
