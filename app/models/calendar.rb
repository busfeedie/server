# frozen_string_literal: true
# typed: strict

# https://gtfs.org/schedule/reference/#calendartxt
class Calendar < ApplicationRecord
  extend T::Sig

  has_many :trips, as: :service
  has_many :calendar_dates

  validates :gtfs_service_id, :start_date, :end_date, presence: true
  validates :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, inclusion: [true, false]

  sig { returns(T::Hash[Integer, T::Boolean]) }
  def days
    {
      1 => monday,
      2 => tuesday,
      3 => wednesday,
      4 => thursday,
      5 => friday,
      6 => saturday,
      7 => sunday
    }
  end

  sig { params(date: Date).returns(T::Boolean) }
  def on_date(date:)
    date.between?(start_date, end_date) && (days[date.cwday] == true)
  end
end
