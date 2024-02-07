# frozen_string_literal: true
# typed: strict

# https://gtfs.org/realtime/reference/#message-vehicledescriptor
class Vehicle < ApplicationRecord
  extend T::Sig

  @label = T.let(nil, T.nilable(String))
  @license_plate = T.let(nil, T.nilable(String))

  has_many :vehicle_positions, inverse_of: :vehicle
  belongs_to :app

  enum :wheelchair_accessible,
       %i[wheelchair_access_no_value wheelchair_access_unknown wheelchair_access_accessible
          wheelchair_access_inaccessible]

  validates :app, presence: true

  sig { returns(T::Hash[Symbol, T.untyped]) }
  def serialize
    {
      id:,
      app_id:,
      label:,
      license_plate:,
      wheelchair_accessible:,
      created_at:,
      updated_at:
    }
  end
end
