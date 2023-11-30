# frozen_string_literal: true
# typed: strict

# https://gtfs.org/schedule/reference/#agencytxt
class Agency < ApplicationRecord
  extend T::Sig

  has_many :routes, inverse_of: :agency
end
