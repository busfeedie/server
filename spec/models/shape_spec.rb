# frozen_string_literal: true
# typed: false

RSpec.describe ::Shape, type: :model do
  context 'when creating a new Shape' do
    it 'should create a new Shape with all attributes populated' do
      expect do
        ::Shape.create!(
          gtfs_shape_id: '123',
          lonlat: 'POINT(-122.123456 47.123456)',
          shape_pt_sequence: 1,
          shape_dist_traveled: 1.0
        )
      end.to change { ::Shape.count }.by(1)
    end
  end
end
