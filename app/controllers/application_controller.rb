# frozen_string_literal: true
# typed: strict

class ApplicationController < ActionController::Base
  extend ::T::Sig

  sig { returns(App) }
  def load_app
    @app = T.let(nil, T.nilable(App))
    @app = App.find(params[:app_id])
  end
end
