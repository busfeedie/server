# frozen_string_literal: true
# typed: strict

module Api
  # This controller is used to manage the live position of vehicles
  class PositionsController < ApplicationController
    extend ::T::Sig
    protect_from_forgery with: :null_session

    sig { returns(String) }
    def create
      params.require(:lat)
      params.require(:lon)
      factory = RGeo::Geographic.spherical_factory(srid: 4326)
      p = factory.point(params[:lon], params[:lat])
      trip_identifier = create_trip_identifier if params[:trip].present?
      position = ::VehiclePosition.create!(lonlat: p, trip_identifier:)
      render json: position
    end

    private

    sig { returns ::TripIdentifier }
    def create_trip_identifier
      trip_data = T.cast(params[:trip], ActionController::Parameters).permit(:start_date, :start_time)
      ::TripIdentifier.find_or_create_by!(start_date: trip_data[:start_date],
                                          start_time: trip_data[:start_time])
    end
  end
end
