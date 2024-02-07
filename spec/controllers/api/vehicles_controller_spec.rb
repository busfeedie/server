# frozen_string_literal: true
# typed: false

RSpec.describe Api::VehiclesController, type: :controller do
  describe 'create' do
    let(:app) { create(:app) }
    let(:user) { create(:user, app:) }
    let(:label) { 'Cool bus' }
    let(:license_plate) { '231-MH-1954' }
    let(:wheelchair_accessible) { :wheelchair_access_accessible }
    let(:params) { { label:, license_plate:, wheelchair_accessible: } }

    before do
      login_user(user:)
    end

    it 'should create a new vehicle' do
      expect do
        post :create, params:
      end.to change { ::Vehicle.count }.by(1)
      expect(response).to have_http_status(:success)
      vehicle = ::Vehicle.last
      expect(response.body).to eq(vehicle.to_json)
      expect(vehicle.label).to eq(label)
      expect(vehicle.license_plate).to eq(license_plate)
      expect(vehicle.wheelchair_access_accessible?).to eq(true)
    end
  end

  describe 'index' do
    let(:app) { create(:app) }
    let(:user) { create(:user, app:) }

    before do
      login_user(user:)
    end

    context 'with no vehicles' do
      it 'should return no vehicles' do
        get(:index)
        expect(response).to have_http_status(:success)
        expect(response.body).to eq('[]')
      end
    end

    context 'with a vehicle' do
      let!(:vehicle) { create(:vehicle, app:) }
      it 'should return the vehicle' do
        get(:index)
        expect(response).to have_http_status(:success)
        expect(response.body).to eq([vehicle.serialize].to_json)
      end
    end
  end
end
