# frozen_string_literal: true
# typed: strict

module Api
  # This controller is used to list the available trips
  class TripsController < ApiController
    extend ::T::Sig
    protect_from_forgery with: :null_session

    sig { returns(String) }
    def index
      render json: ::Trip.where(app: params[:app_id]).map(&:serialize)
    end
  end
end
