# frozen_string_literal: true
# typed: false

RSpec.describe ::Trip, type: :model do
  context 'when creating a new trip' do
    it 'should create a new trip without shapes if not continuous pickup / dropoff' do
      expect do
        ::Trip.create!(
          trip_headsign: 'to City Centre',
          trip_short_name: 'to City Centre',
          direction: :inbound,
          block_id: '123',
          wheelchair_accessible: :wheelchair_accessible,
          bikes_allowed: :bikes_allowed,
          route: create(:route),
          calendar: create(:calendar)
        )
      end.to change { ::Trip.count }.by(1)
    end
    it 'should create a new trip with a shape if continuous pickup' do
      expect do
        ::Trip.create!(
          trip_headsign: 'to City Centre',
          trip_short_name: 'to City Centre',
          direction: :inbound,
          block_id: '123',
          wheelchair_accessible: :wheelchair_accessible,
          bikes_allowed: :bikes_allowed,
          route: create(:route, continuous_pickup: :continuous),
          calendar: create(:calendar)
        )
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
    it 'should create a new trip with a shape if continuous pickup' do
      expect do
        ::Trip.create!(
          trip_headsign: 'to City Centre',
          trip_short_name: 'to City Centre',
          direction: :inbound,
          block_id: '123',
          wheelchair_accessible: :wheelchair_accessible,
          bikes_allowed: :bikes_allowed,
          shape: create(:shape),
          route: create(:route, continuous_pickup: :continuous),
          calendar: create(:calendar)
        )
      end.to change { ::Trip.count }.by(1)
    end
  end
end
