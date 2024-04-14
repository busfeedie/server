# frozen_string_literal: true
# typed: strict

module Admin
  # This controller is used to list the available trips
  class AppsController < Admin::AdminController
    extend ::T::Sig

    sig { void }
    def index
      @apps = T.let(App.all.to_a, T.nilable(T::Array[App]))
    end

    sig { void }
    def show
      @app = T.let(App.find_by(id: params[:id]), T.nilable(App))
      redirect_to action: 'index' unless @app
      flash.alert = 'App not found' unless @app
      render layout: 'admin/app'
    end

    sig { void }
    def create
      @app = T.let(App.create!, T.nilable(App))
      redirect_to action: 'show', id: @app.id if @app
      return if @app

      flash.alert = 'App not found'
      redirect_to action: 'index'
    end
  end
end
