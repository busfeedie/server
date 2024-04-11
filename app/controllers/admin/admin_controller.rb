# frozen_string_literal: true
# typed: strict

module Admin
  # This is the parent class of all other public api controllers
  class AdminController < ActionController::Base
    extend ::T::Sig

    before_action :authenticate_user!

    sig { void }
    def verify_admin
      raise(ActionController::RoutingError, 'Not Found') unless current_user&.admin?

      @curent_admin = T.let(current_user, T.nilable(User))
    end
  end
end
