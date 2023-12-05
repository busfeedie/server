# frozen_string_literal: true
# typed: strict

# https://gtfs.org/schedule/reference/#agencytxt
class Agency < ApplicationRecord
  extend T::Sig
  has_many :routes, inverse_of: :agency

  validates :gtfs_agency_id, :agency_name, :agency_url, :agency_timezone, presence: true
end
