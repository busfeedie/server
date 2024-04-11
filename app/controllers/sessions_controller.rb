# frozen_string_literal: true

# Controller for user sessions
class SessionsController < Devise::SessionsController
  respond_to :html, :json
  protect_from_forgery with: :null_session
end
