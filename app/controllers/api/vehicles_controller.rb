# frozen_string_literal: true
# typed: false

module Api
  # This controller is used to add new vehicles to the system
  class VehiclesController < ApiController
    extend ::T::Sig
    before_action :load_app

    sig { returns(String) }
    def create
      vehicle = ::Vehicle.create!(app: @app, label: params[:label], license_plate: params[:license_plate],
                                  wheelchair_accessible: params[:wheelchair_accessible])
      render json: vehicle
    end
  end
end
