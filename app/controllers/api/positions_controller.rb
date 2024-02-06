# frozen_string_literal: true
# typed: false

module Api
  # This controller is used to manage the live position of vehicles
  class PositionsController < ApiController
    extend ::T::Sig
    before_action :load_app

    sig { returns(String) }
    def create
      factory = RGeo::Geographic.spherical_factory(srid: 4326)
      p = factory.point(params[:lon], params[:lat])
      trip_identifier = create_trip_identifier if params[:trip].present?
      position = ::VehiclePosition.create!(lonlat: p, trip_identifier:, app: @app, trip: trip_identifier.trip)
      render json: position
    end

    private

    sig { returns ::TripIdentifier }
    def create_trip_identifier
      trip_data = T.cast(params[:trip], ActionController::Parameters).permit(:start_date, :start_time, :trip_id,
                                                                             :gtfs_trip_id)
      trip = get_trip(trip_data:)
      ::TripIdentifier.find_or_create_by!(start_date: trip_data[:start_date],
                                          start_time: trip_data[:start_time],
                                          app: @app,
                                          gtfs_trip_id: trip_data[:gtfs_trip_id],
                                          trip:)
    end

    def get_trip(trip_data:)
      trip = ::Trip.find_by(app_id: T.must(@app).id, id: trip_data[:trip_id]) if trip_data[:trip_id].present?
      return trip unless trip.blank?

      trip ||= ::Trip.find_by(app_id: T.must(@app).id,
                              gtfs_trip_id: trip_data[:gtfs_trip_id])
      trip
    end
  end
end
