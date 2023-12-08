# frozen_string_literal: true

FactoryBot.define do
  factory :agency, class: '::Agency' do
    app { create(:app) }
    gtfs_agency_id { '123' }
    agency_name { 'Agency Name' }
    agency_url { 'https://example.com' }
    agency_timezone { 'Europe/Dublin' }
    agency_lang { 'en' }
    agency_phone { '087-123-4567' }
    agency_fare_url { 'https://example.com' }
    agency_email { '123@example.com' }
  end
end
