# frozen_string_literal: true
# typed: strict

module Api
  # This is the parent class of all other API controllers
  class ApiController < ApplicationController
    extend ::T::Sig
    protect_from_forgery with: :null_session

    before_action :authenticate_user!

    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    sig { returns(App) }
    def load_app
      @app = current_user.app
      redirect_to user_session_path if @app.blank?
      @app
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
