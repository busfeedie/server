# frozen_string_literal: true
# typed: strict

module Api
  # This controller is used to list the available trips
  class TripsController < ApiController
    extend ::T::Sig

    before_action :load_app

    sig { returns(String) }
    def index
      trips = ::Trip.where(app: @app)
      trips = trips.where(route_id: params[:route_id]) if params[:route_id].present?
      render json: trips.map(&:serialize)
    end
  end
end
