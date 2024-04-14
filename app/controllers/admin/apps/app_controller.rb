# frozen_string_literal: true
# typed: strict

module Admin
  module Apps
    # This controller is used to list the available trips
    class AppController < Admin::AdminController
      extend ::T::Sig
      layout 'admin/app'

      before_action :load_app

      sig { returns(T.nilable(App)) }
      def load_app
        @app = T.let(App.find_by(id: params[:app_id]), T.nilable(App))
        redirect_to action: 'index' unless @app
        flash.alert = 'App not found' unless @app
      end
    end
  end
end
