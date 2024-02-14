# frozen_string_literal: true
# typed: strict

# https://gtfs.org/schedule/reference/#shapestxt
# This identifies the whole path that a vehicle travels on a particular trip.
class Shape < ApplicationRecord
  extend T::Sig

  has_many :trips, inverse_of: :shape
  has_many :shape_points, inverse_of: :shape, dependent: :destroy

  validates :gtfs_shape_id, presence: true
end
