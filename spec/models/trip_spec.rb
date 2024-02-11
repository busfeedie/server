# frozen_string_literal: true
# typed: false

RSpec.describe ::Trip, type: :model do
  let(:app) { create(:app) }
  context 'when creating a new trip' do
    it 'should create a new trip without shapes if not continuous pickup / dropoff' do
      expect do
        ::Trip.create!(
          app:,
          gtfs_trip_id: '123',
          trip_headsign: 'to City Centre',
          trip_short_name: 'to City Centre',
          direction: :inbound,
          block_id: '123',
          wheelchair_accessible: :wheelchair_accessible,
          bikes_allowed: :bikes_allowed,
          route: create(:route),
          service: create(:calendar)
        )
      end.to change { ::Trip.count }.by(1)
    end
    it 'should create a new trip with a shape if continuous pickup' do
      expect do
        ::Trip.create!(
          app:,
          gtfs_trip_id: '123',
          trip_headsign: 'to City Centre',
          trip_short_name: 'to City Centre',
          direction: :inbound,
          block_id: '123',
          wheelchair_accessible: :wheelchair_accessible,
          bikes_allowed: :bikes_allowed,
          route: create(:route, continuous_pickup: :continuous),
          service: create(:calendar)
        )
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
    it 'should create a new trip with a shape if continuous pickup' do
      expect do
        ::Trip.create!(
          app:,
          gtfs_trip_id: '123',
          trip_headsign: 'to City Centre',
          trip_short_name: 'to City Centre',
          direction: :inbound,
          block_id: '123',
          wheelchair_accessible: :wheelchair_accessible,
          bikes_allowed: :bikes_allowed,
          shape: create(:shape),
          route: create(:route, continuous_pickup: :continuous),
          service: create(:calendar)
        )
      end.to change { ::Trip.count }.by(1)
    end
  end
  context 'runs_on_date' do
    let(:start_date) { Date.parse('2024-02-01') }
    let(:end_date) { Date.parse('2024-02-29') }
    let(:service) { create(:calendar, monday: false, start_date:, end_date:) }
    let(:trip) { create(:trip, app:, service:) }
    it 'should return true if the trip runs on the date' do
      date = Date.parse('2024-02-10') # a saturday
      expect(trip.runs_on_date(date:)).to eq(true)
    end
    it 'should return false if the trip does not run on the day of the week' do
      date = Date.parse('2024-02-12') # a monday
      expect(trip.runs_on_date(date:)).to eq(false)
    end
    it 'should return false if the trip is not within the date range' do
      date = Date.parse('2024-01-31') # a wednesday
      expect(trip.runs_on_date(date:)).to eq(false)
    end
  end
  context 'serialize' do
    let(:trip) do
      create(
        :trip,
        app:,
        route: create(:route),
        service: create(:calendar)
      )
    end
    let!(:stop_time) { create(:stop_time, trip:, app:) }
    it 'should return a hash' do
      expect(trip.serialize).to be_a(Hash)
    end
    it 'should include the first stop time' do
      expect(trip.serialize[:first_stop_time]).to eq(stop_time.departure_time)
    end
    it 'should include the days the trip runs' do
      expect(trip.serialize[:days]).to eq(trip.service.days)
    end
    it 'should include whether the trip runs today' do
      expect(trip.serialize[:today]).to eq(trip.service.on_date(date: Date.today))
    end
  end
end
