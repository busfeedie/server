# frozen_string_literal: true

# Controller for user registration
class RegistrationsController < Devise::RegistrationsController
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def respond_with(resource, _opts = {})
    puts "resource: #{resource.inspect}"
    if resource.persisted?
      render json: { status: { code: 200, message: 'Signed up sucessfully.' }, data: { email: resource.email } }
    else
      render json: {
        status: { message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password])
  end
end
