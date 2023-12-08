# frozen_string_literal: true
# typed: false

RSpec.describe Api::TripsController, type: :controller do
  let(:app) { create(:app) }
  describe 'index' do
    let(:params) { { app_id: app.id } }
    let(:subject) do
      get :index, params:
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
      it 'should return no trips' do
        subject
        expect(response).to have_http_status(:success)
        expect(response.body).to eq([trip.serialize].to_json)
      end
    end
  end
end
