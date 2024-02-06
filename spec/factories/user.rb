# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: '::User' do
    app { create(:app) }
    password { '1-2&afghy67' }
    sequence(:email, 1000) { |n| "person#{n}@example.com" }
  end
end
