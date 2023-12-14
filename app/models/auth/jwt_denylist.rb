# frozen_string_literal: true
# typed: strict

module Auth
  # For managing rejection of old tokens
  class JwtDenylist < ApplicationRecord
    include Devise::JWT::RevocationStrategies::Denylist

    self.table_name = 'jwt_denylists'
  end
end
