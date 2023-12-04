# frozen_string_literal: true
# typed: false

RSpec.describe ::CalendarDate, type: :model do
  context 'when creating a new calendar date' do
    it 'should create a new calendar date with all attributes populated' do
      expect do
        ::CalendarDate.create!(
          calendar: create(:calendar),
          date: Date.today,
          exception_type: :added
        )
      end.to change { ::CalendarDate.count }.by(1)
    end
  end
end
