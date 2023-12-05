# frozen_string_literal: true

# Applies to all models in the app/models directory
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  belongs_to :app
  validates :app, presence: true
end
