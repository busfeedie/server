# frozen_string_literal: true
# typed: false

desc 'Deletes all the data in an app including its users'
task :delete_app, %i[app_id] => :environment do |_t, args|
  require 'csv'
  app = ::App.find(args.app_id)
  Rails.logger.info("Deleting app_id: #{args.app_id}")
  ActiveRecord::Base.transaction do
    Rails.logger.info('Deleting users')
    app.users.destroy_all
    Rails.logger.info('Deleting agencies')
    app.agencies.destroy_all
    Rails.logger.info('Deleting calendars')
    app.calendars.destroy_all
    Rails.logger.info('Deleting calendar_dates')
    app.calendar_dates.destroy_all
    Rails.logger.info('Deleting routes')
    app.routes.destroy_all
    Rails.logger.info('Deleting shapes')
    app.shapes.destroy_all
    Rails.logger.info('Deleting stops')
    app.stops.destroy_all
    Rails.logger.info('Deleting stop_times')
    app.stop_times.destroy_all
    Rails.logger.info('Deleting trips')
    app.trips.destroy_all
    Rails.logger.info('Deleting trip_identifiers')
    app.trip_identifiers.destroy_all
    Rails.logger.info('Deleting vehicle_positions')
    app.vehicle_positions.destroy_all
    Rails.logger.info('Deleting vehicles')
    app.vehicles.destroy_all
    Rails.logger.info('Deleting app')
    app.destroy!
    Rails.logger.info('Finished deleting')
  end
end
