# frozen_string_literal: true
# typed: strict

# https://gtfs.org/realtime/reference/#message-vehicledescriptor
class Vehicle < ApplicationRecord
  extend T::Sig

  @label = T.let(nil, T.nilable(String))
  @license_plate = T.let(nil, T.nilable(String))

  has_many :vehicle_positions, inverse_of: :vehicle
  belongs_to :app

  enum :wheelchair_accessible, %i[no_value unknown accessible inaccessible], _prefix: true

  validates :app, presence: true
end
