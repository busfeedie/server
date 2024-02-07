# frozen_string_literal: true
# typed: strict

# This is the parent class of all other controllers
# Any controller should generally call the load_app method
class ApplicationController < ActionController::Base
  extend ::T::Sig

  sig { returns(App) }
  def load_app
    params.require(:app_id)
    @app = T.let(nil, T.nilable(App))
    @app = App.find(params[:app_id])
    redirect_to user_session_path if @app.blank?
    @app
  end
end
