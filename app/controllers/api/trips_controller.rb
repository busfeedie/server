# frozen_string_literal: true
# typed: strict

module Api
  # This controller is used to list the available trips
  class TripsController < ApiController
    extend ::T::Sig

    before_action :load_app

    sig { returns(String) }
    def index
      render json: ::Trip.where(app: @app).map(&:serialize)
    end
  end
end
