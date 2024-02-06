# frozen_string_literal: true
# typed: strict

module Api
  # This is the parent class of all other API controllers
  class ApiController < ApplicationController
    extend ::T::Sig
    protect_from_forgery with: :null_session

    before_action :authenticate_user!
    before_action :verify_app_access

    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    sig { returns(T.nilable(String)) }
    def verify_app_access
      @app = load_app
      return unless @app.blank? || @app.id != current_user.app_id

      render json: {
        'errors': [
          {
            'status': '403',
            'title': 'Forbidden'
          }
        ]
      }, status: 403
    end

    sig { returns(String) }
    def not_found
      render json: {
        'errors': [
          {
            'status': '404',
            'title': 'Not Found'
          }
        ]
      }, status: 404
    end
  end
end
