Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://api.busfeed.ie'
    resource(
      '*',
      headers: :any,
      expose: %w[access-token expiry token-type Authorization],
      methods: %i[get patch put delete post options show]
    )
  end
  allow do
    origins 'http://localhost:3000', 'https://web.busfeed.ie', 'http://localhost:52609'
    resource(
      '*',
      headers: :any,
      expose: %w[access-token expiry token-type Authorization],
      methods: %i[get patch put delete post options show]
    )
  end
end
