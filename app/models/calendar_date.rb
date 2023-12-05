# frozen_string_literal: true
# typed: strict

# https://gtfs.org/schedule/reference/#calendar_datestxt
class CalendarDate < ApplicationRecord
  extend T::Sig

  enum exception_type: %i[added removed]

  belongs_to :calendar, optional: true
  has_many :trips, as: :service

  validates :date, :calendar, :exception_type, presence: true
end
