# frozen_string_literal: true
# typed: false

RSpec.describe Api::PositionsController, type: :controller do
  describe 'create' do
    let(:app) { create(:app) }
    let(:params) { { lat: 47.621, lon: -122.345, app_id: app.id } }
    it 'should create a new position from the lat and lon parameters' do
      expect do
        post :create, params:
      end.to change { ::VehiclePosition.count }.by(1)
      expect(response).to have_http_status(:success)
      position = ::VehiclePosition.last
      expect(response.body).to eq(position.to_json)
      expect(position.lonlat.lon).to eq(-122.345)
      expect(position.lonlat.lat).to eq(47.621)
    end

    it 'should create a new position from a point' do
      params[:trip] = { start_time: '22:50:00' }
      expect do
        post :create, params:
      end.to change { ::VehiclePosition.count }.by(1)
      expect(response).to have_http_status(:success)
      position = ::VehiclePosition.last
      expect(position.trip_identifier.start_time_string).to eq('22:50:00')
    end
  end
end
