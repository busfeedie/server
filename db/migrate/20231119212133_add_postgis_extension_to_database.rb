# frozen_string_literal: true

# Makes sure postgis is enabled in the database
class AddPostgisExtensionToDatabase < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'postgis'
  end
end
