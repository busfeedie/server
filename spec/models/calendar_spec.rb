# frozen_string_literal: true
# typed: false

RSpec.describe ::Calendar, type: :model do
  context 'when creating a new calendar' do
    it 'should create a new calendar with all attributes populated' do
      expect do
        ::Calendar.create!(
          gtfs_service_id: '123-1-1',
          start_date: '2023-08-17',
          end_date: '2023-09-25',
          monday: true,
          tuesday: true,
          wednesday: true,
          thursday: true,
          friday: true,
          saturday: true,
          sunday: true
        )
      end.to change { ::Calendar.count }.by(1)
    end
  end
end
