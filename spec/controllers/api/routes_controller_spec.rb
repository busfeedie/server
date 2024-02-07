# frozen_string_literal: true
# typed: false

RSpec.describe Api::RoutesController, type: :controller do
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

    context 'with no routes' do
      it 'should return no routes' do
        subject
        expect(response).to have_http_status(:success)
        expect(response.body).to eq('[]')
      end
    end

    context 'with a route' do
      let!(:route) { create(:route, app:) }
      it 'should return the route' do
        subject
        expect(response).to have_http_status(:success)
        expect(response.body).to eq([route.serialize].to_json)
      end
    end
  end
end
