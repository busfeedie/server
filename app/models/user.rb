# frozen_string_literal: true

# User login model generated by devise
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :set_app

  def set_app
    self.app ||= App.create!(name: "#{email}'s app")
  end
end
