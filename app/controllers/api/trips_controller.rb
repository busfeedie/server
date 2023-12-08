# frozen_string_literal: true
# typed: strict

module Api
  # This controller is used to list the available trips
  class TripsController < ApplicationController
    extend ::T::Sig
    protect_from_forgery with: :null_session
    before_action :load_app

    sig { returns(String) }
    def index
      render json: ::Trip.where(app: params[:app_id]).map(&:serialize)
    end
  end
end
