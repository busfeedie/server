# frozen_string_literal: true
# typed: strict

# https://gtfs.org/realtime/reference/#message-vehicleposition
class TripIdentifier < ActiveRecord::Base
  extend T::Sig

  @start_date = T.let(nil, T.nilable(Date))
  @start_time = T.let(nil, T.nilable(Time))
  @created_at = T.let(nil, T.nilable(DateTime))
  @updated_at = T.let(nil, T.nilable(DateTime))
end
