# frozen_string_literal: true
# typed: false

# User login model generated by devise
class User < ApplicationRecord
  extend T::Sig

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: ::Auth::JwtDenylist

  before_validation :set_app

  sig { returns(App) }
  def set_app
    self.app ||= App.create!(name: "#{email}'s app")
  end

  sig { returns(T::Boolean) }
  def admin?
    email == 'diarmuid@busfeed.ie' || email == 'example@busfeed.ie'
  end
end
