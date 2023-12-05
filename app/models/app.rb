# frozen_string_literal: true
# typed: strict

# This represents a particular public transport company and references the objects that belong to it.
class App < ActiveRecord::Base
  extend T::Sig
  has_many :agencies, inverse_of: :app
  has_many :calendars, inverse_of: :app
  has_many :calendar_dates, inverse_of: :app
  has_many :routes, inverse_of: :app
  has_many :shapes, inverse_of: :app
  has_many :stops, inverse_of: :app
  has_many :stop_times, inverse_of: :app
  has_many :trips, inverse_of: :app
  has_many :trip_identifiers, inverse_of: :app
  has_many :vehicle_positions, inverse_of: :app
end
