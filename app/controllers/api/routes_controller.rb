# frozen_string_literal: true
# typed: strict

module Api
  # This controller is used to list the available trips
  class RoutesController < ApiController
    extend ::T::Sig
    before_action :load_app

    sig { returns(String) }
    def index
      render json: ::Route.where(app: @app).map(&:serialize)
    end
  end
end
