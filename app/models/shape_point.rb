# frozen_string_literal: true
# typed: strict

# https://gtfs.org/schedule/reference/#shapestxt
#   This contains an individual piece of the path a vehicle travels on a particular trip.
class ShapePoint < ApplicationRecord
  extend T::Sig
  include Pointable

  belongs_to :shape, inverse_of: :shape_points

  validates :lonlat, :shape_pt_sequence, presence: true
end
