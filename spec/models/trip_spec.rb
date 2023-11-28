# frozen_string_literal: true
# typed: false

RSpec.describe ::Trip, type: :model do
  context 'when creating a new trip' do
    it 'should create a new position from a string' do
      expect do
        ::Trip.create!(
          gtfs_trip_id: '123-a-5',
          gtfs_route_id: '123',
          gtfs_service_id: 'a',
          trip_headsign: 'to City Centre',
          trip_short_name: 'to City Centre',
          direction: :inbound,
          block_id: '123',
          gtfs_shape_id: '123',
          wheelchair_accessible: :wheelchair_accessible,
          bikes_allowed: :bikes_allowed
        )
      end.to change { ::Trip.count }.by(1)
    end
  end
end
