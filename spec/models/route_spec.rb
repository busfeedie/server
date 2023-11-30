# frozen_string_literal: true
# typed: false

RSpec.describe ::Route, type: :model do
  context 'when creating a new route' do
    it 'should create a new route with all attributes populated' do
      expect do
        ::Route.create!(
          gtfs_route_id: '123-a-5',
          agency: create(:agency),
          route_short_name: '123',
          route_long_name: 'to City Centre',
          route_desc: 'to City Centre',
          route_type: :bus,
          route_url: 'https://example.com',
          route_color: 'ffffff',
          route_text_color: '000000',
          route_sort_order: 1,
          continuous_pickup: :continuous,
          continuous_drop_off: :continuous
        )
      end.to change { ::Route.count }.by(1)
    end
  end

  it 'validates that long name or short name is present' do
    expect do
      ::Route.create!(
        gtfs_route_id: '123-a-5',
        agency: create(:agency),
        route_type: :bus
      )
    end.to raise_error(ActiveRecord::RecordInvalid)
    expect do
      ::Route.create!(
        gtfs_route_id: '123-a-5',
        agency: create(:agency),
        route_long_name: 'to City Centre',
        route_type: :bus
      )
    end.to change { ::Route.count }.by(1)
    expect do
      ::Route.create!(
        gtfs_route_id: '123-a-5',
        agency: create(:agency),
        route_short_name: 'to City Centre',
        route_type: :bus
      )
    end.to change { ::Route.count }.by(1)
  end

  context '#any_continuous?' do
    it 'returns true if continuous_pickup is available' do
      route = create(:route, continuous_pickup: :continuous)
      expect(route.any_continuous?).to eq(true)
    end
    it 'returns true if continuous_dropoff is available' do
      route = create(:route, continuous_drop_off: :continuous)
      expect(route.any_continuous?).to eq(true)
    end
    it 'returns false if no continuous pickup or dropoff' do
      route = create(:route)
      expect(route.any_continuous?).to eq(false)
    end
  end
end
