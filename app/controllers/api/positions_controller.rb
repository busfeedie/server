# frozen_string_literal: true
# typed: false

module Api
  # This controller is used to manage the live position of vehicles
  class PositionsController < ApiController
    extend ::T::Sig
    before_action :load_app

    sig { returns(String) }
    def create
      p = geo_point(lon: params[:lon], lat: params[:lat])
      trip_identifier = create_trip_identifier if params[:trip].present?
      vehicle = ::Vehicle.find_by(app_id: T.must(@app).id, id: params[:vehicle_id])
      position = ::VehiclePosition.create!(
        lonlat: p,
        trip_identifier:,
        app: @app,
        trip: trip_identifier&.trip,
        vehicle:
      )
      render json: position
    end

    sig { returns(String) }
    def latest
      position = get_latest_position_from_trip
      position = get_latest_position_from_vehicle if position.blank?
      render json: position
    end

    private

    sig { returns ::TripIdentifier }
    def create_trip_identifier
      trip_data = get_trip_data
      trip = get_trip(trip_data:)
      ::TripIdentifier.find_or_create_by!(start_date: trip_data[:start_date],
                                          start_time: trip_data[:start_time],
                                          app: @app,
                                          gtfs_trip_id: trip_data[:gtfs_trip_id],
                                          trip:)
    end

    def get_latest_position_from_trip
      trip = get_trip(trip_data: get_trip_data) if params[:trip].present?
      position = ::VehiclePosition.where(app: @app, trip:).order(:created_at).last if trip.present?
      position
    end

    def get_latest_position_from_vehicle
      vehicle = ::Vehicle.find_by(app: @app, id: params[:vehicle_id]) if params[:vehicle_id].present?
      position = ::VehiclePosition.where(app: @app, vehicle:).order(:created_at).last if vehicle.present?
      position
    end

    def get_trip(trip_data:)
      trip = ::Trip.find_by(app: @app, id: trip_data[:trip_id]) if trip_data[:trip_id].present?
      return trip unless trip.blank?

      trip ||= ::Trip.find_by(app: @app, gtfs_trip_id: trip_data[:gtfs_trip_id]) if trip_data[:gtfs_trip_id].present?
      trip
    end

    sig { params(lat: String, lon: String).returns(RGeo::Geographic::SphericalPointImpl) }
    def geo_point(lat:, lon:)
      RGeo::Geographic.spherical_factory(srid: 4326).point(lon, lat)
    end

    sig { returns ::ActionController::Parameters }
    def get_trip_data
      trip_data = T.cast(params[:trip], ActionController::Parameters).permit(:start_date, :start_time, :trip_id,
                                                                             :gtfs_trip_id)
    end
  end
end
