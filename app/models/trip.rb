# frozen_string_literal: true
# typed: strict

# https://gtfs.org/schedule/reference/#tripstxt
class Trip < ApplicationRecord
  enum direction: %i[outbound inbound]
  enum wheelchair_accessible: %i[wheelchair_accessibility_unknown wheelchair_accessible wheelchair_not_accessible]
  enum bikes_allowed: %i[bikes_unknown bikes_allowed bikes_not_allowed]
end
