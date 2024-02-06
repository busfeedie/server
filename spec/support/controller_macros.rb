# frozen_string_literal: true

module ControllerMacros
  def login_admin
    @request.env['devise.mapping'] = Devise.mappings[:admin]
    sign_in FactoryBot.create(:admin) # Using factory bot as an example
  end

  def login_user(user: nil)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user ||= FactoryBot.create(:user)
    sign_in user
  end
end
