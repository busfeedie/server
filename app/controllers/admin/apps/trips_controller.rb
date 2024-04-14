# frozen_string_literal: true
# typed: strict

module Admin
  module Apps
    # This controller is used to list the available trips
    class TripsController < Admin::Apps::AppController
      extend ::T::Sig

      sig { void }
      def index
        @trips = T.let(Trip.where(app: @app).to_a, T.nilable(T::Array[Trip]))
      end

      sig { void }
      def show
        @trip = T.let(Trip.find_by(app: @app, id: params[:id]), T.nilable(Trip))
        @latest_positions = T.let(@trip&.vehicle_positions&.order(created_at: :desc)&.limit(50).to_a,
                                  T.nilable(T::Array[VehiclePosition]))
      end
    end
  end
end
