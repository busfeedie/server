# frozen_string_literal: true
# typed: strict

# https://gtfs.org/schedule/reference/#calendartxt
class Calendar < ApplicationRecord
  extend T::Sig

  has_many :trips, inverse_of: :calendar

  validates :gtfs_service_id, :start_date, :end_date, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday,
            presence: true
end
