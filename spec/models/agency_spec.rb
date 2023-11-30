# frozen_string_literal: true
# typed: false

RSpec.describe ::Agency, type: :model do
  context 'when creating a new Agency' do
    it 'should create a new Agency with all attributes populated' do
      expect do
        ::Agency.create!(
          gtfs_agency_id: '123',
          agency_name: 'Agency Name',
          agency_url: 'https://example.com',
          agency_timezone: 'America/Los_Angeles',
          agency_lang: 'en',
          agency_phone: '555-555-5555',
          agency_fare_url: 'https://example.com',
          agency_email: '123@example.com'
        )
      end.to change { ::Agency.count }.by(1)
    end
  end
end
