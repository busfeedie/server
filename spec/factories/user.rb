# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: '::User' do
    app { create(:app) }
    email { 'example+test@busfeed.ie' }
    password { '1-2&afghy67' }
  end
end
