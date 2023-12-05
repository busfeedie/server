# frozen_string_literal: true
# typed: strict

# https://gtfs.org/schedule/reference/#shapestxt
class Shape < ApplicationRecord
  extend T::Sig
  include Pointable

  has_many :trips

  validates :gtfs_shape_id, :lonlat, :shape_pt_sequence, presence: true
end
