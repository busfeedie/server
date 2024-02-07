# frozen_string_literal: true

FactoryBot.define do
  factory :vehicle, class: '::Vehicle' do
    app { create(:app) }
    label { 'A big bus' }
    wheelchair_accessible { 0 }
    sequence(:license_plate, 1000) { |n| "231-MH-#{n}" }
  end
end
