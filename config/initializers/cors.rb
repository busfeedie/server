Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3000'
    resource(
      '*',
      headers: :any,
      expose: %w[access-token expiry token-type Authorization],
      methods: %i[get patch put delete post options show]
    )
  end
  allow do
    origins 'https://web.busfeed.ie'
    resource(
      '*',
      headers: :any,
      expose: %w[access-token expiry token-type Authorization],
      methods: %i[get patch put delete post options show]
    )
  end
  allow do
    origins 'https://api.busfeed.ie'
    resource(
      '*',
      headers: :any,
      expose: %w[access-token expiry token-type Authorization],
      methods: %i[get patch put delete post options show]
    )
  end
end
