# frozen_string_literal: true
# typed: strict

module Api
  # This controller is used to list the available trips
  class TripsController < ApiController
    extend ::T::Sig

    before_action :load_app

    sig { returns(String) }
    def index
      trips = ::Trip.where(app: @app).includes(:service, :stop_times)
      trips = trips.where(route_id: params[:route_id]) if params[:route_id].present?
      trips = trips.select { |trip| trip.runs_on_date(date: Date.parse(params[:date])) } if params[:date].present?
      render json: trips.map(&:serialize)
    end

    sig { returns(String) }
    def stops
      trip = ::Trip.find(params[:id])
      render json: ::StopTime.where(app: @app, trip:).map(&:serialize)
    end
  end
end
