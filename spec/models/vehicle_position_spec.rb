# frozen_string_literal: true
# typed: false

RSpec.describe VehiclePosition, type: :model do
  context 'when creating a new position' do
    it 'should create a new position' do
      expect do
        ::VehiclePosition.create!(lonlat: 'POINT(-122.345 47.621)')
      end.to change { ::VehiclePosition.count }.by(1)
    end
  end
end
