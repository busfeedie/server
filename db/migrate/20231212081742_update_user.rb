# frozen_string_literal: true

class UpdateUser < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :app, index: true, null: false
  end
end
