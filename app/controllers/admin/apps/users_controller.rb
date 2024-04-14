# frozen_string_literal: true
# typed: strict

module Admin
  module Apps
    # This controller is used to list the available trips
    class UsersController < Admin::Apps::AppController
      extend ::T::Sig

      sig { void }
      def index
        @users = T.let(User.where(app: @app).to_a, T.nilable(T::Array[User]))
      end
    end
  end
end
