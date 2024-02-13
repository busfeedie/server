# frozen_string_literal: true
# typed: false

RSpec.describe Api::TripsController, type: :controller do
  let(:app) { create(:app) }
  describe 'index' do
    let(:params) { { app_id: app.id } }
    let(:subject) do
      get :index, params:
    end
    let(:user) { create(:user, app:) }

    before do
      login_user(user:)
    end

    context 'with no trips' do
      it 'should return no trips' do
        subject
        expect(response).to have_http_status(:success)
        expect(response.body).to eq('[]')
      end
    end

    context 'with a trip' do
      let!(:trip) { create(:trip, app:) }
      it 'should return the trip' do
        subject
        expect(response).to have_http_status(:success)
        expect(response.body).to eq([trip.serialize].to_json)
      end
      it 'returns the trip if the route id matches' do
        params[:route_id] = trip.route_id
        subject
        expect(response).to have_http_status(:success)
        expect(response.body).to eq([trip.serialize].to_json)
      end
      it 'returns nothing if the route id does not match' do
        params[:route_id] = '1565616841631365'
        subject
        expect(response).to have_http_status(:success)
        expect(response.body).to eq([].to_json)
      end

      context 'with a date' do
        let(:date) { '2024-02-01' }
        let(:start_date) { Date.parse('2024-02-01') }
        let(:end_date) { Date.parse('2024-02-29') }
        let(:service) { create(:calendar, monday: false, start_date:, end_date:) }
        let!(:trip) { create(:trip, app:, service:) }
        it 'returns the trip if it runs on the date' do
          params[:date] = date
          subject
          expect(response).to have_http_status(:success)
          expect(response.body).to eq([trip.serialize].to_json)
        end
        it 'returns nothing if the trip does not run on the date' do
          params[:date] = '2024-01-29'
          subject
          expect(response).to have_http_status(:success)
          expect(response.body).to eq([].to_json)
        end
      end
    end
  end

  describe 'stops' do
    let(:app) { create(:app) }
    let(:trip) { create(:trip, app:) }
    let!(:stop_times) { create_list(:stop_time, 3, app:, trip:) }
    let(:params) { { id: trip.id } }
    let(:user) { create(:user, app:) }

    before do
      login_user(user:)
    end

    let(:subject) do
      get :stops, params:
    end

    it 'should return the stop times for the trip' do
      subject
      expect(response).to have_http_status(:success)
      expect(response.body).to eq(stop_times.map(&:serialize).to_json)
    end
  end

  describe 'latest_position' do
    let(:app) { create(:app) }
    let(:trip) { create(:trip, app:) }
    let!(:vehicle_position) { create(:vehicle_position, app:, trip:) }
    let(:params) { { id: trip.id } }
    let(:user) { create(:user, app:) }

    before do
      login_user(user:)
    end

    let(:subject) do
      get :latest_position, params:
    end

    it 'should return the latest vehicle position for the trip' do
      subject
      expect(response).to have_http_status(:success)
      expect(response.body).to eq(vehicle_position.serialize.to_json)
    end
  end
end
