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
  end
end
