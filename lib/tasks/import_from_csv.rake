# frozen_string_literal: true
# typed: false

desc "Imports an agency's GTFS data from a CSV file"
task :import_from_csv, %i[csv_folder_name app_id file] => :environment do |_t, args|
  require 'csv'
  app = ::App.find(args.app_id)
  path = "lib/data/#{args.csv_folder_name}/"
  file = args.file
  Rails.logger.info("csv_folder_name: #{args.csv_folder_name}, app_id: #{args.app_id}, file: #{args.file}")
  ActiveRecord::Base.transaction do
    if file.blank? || file == 'agency'
      Rails.logger.info("Importing data from #{path}agency.txt")
      CSV.foreach("#{path}agency.txt", headers: true) do |row|
        ::Agency.create!(
          app:,
          gtfs_agency_id: row['agency_id'],
          agency_name: row['agency_name'],
          agency_url: row['agency_url'],
          agency_timezone: row['agency_timezone'],
          agency_lang: row['agency_lang'],
          agency_phone: row['agency_phone'],
          agency_fare_url: row['agency_fare_url'],
          agency_email: row['agency_email']
        )
      end
    end
    if file.blank? || file == 'calendar'
      Rails.logger.info("Importing data from #{path}calendar.txt")
      CSV.foreach("#{path}calendar.txt", headers: true) do |row|
        ::Calendar.create!(
          app:,
          gtfs_service_id: row['service_id'],
          monday: row['monday'] == '1',
          tuesday: row['tuesday'] == '1',
          wednesday: row['wednesday'] == '1',
          thursday: row['thursday'] == '1',
          friday: row['friday'] == '1',
          saturday: row['saturday'] == '1',
          sunday: row['sunday'] == '1',
          start_date: row['start_date'],
          end_date: row['end_date']
        )
      end
    end
    if file.blank? || file == 'calendar_dates'
      Rails.logger.info("Importing data from #{path}calendar_dates.txt")
      CSV.foreach("#{path}calendar_dates.txt", headers: true) do |row|
        ::CalendarDate.create!(
          app:,
          calendar: ::Calendar.find_by(gtfs_service_id: row['service_id']),
          gtfs_service_id: row['service_id'],
          date: row['date'],
          exception_type: row['exception_type'].presence&.to_i
        )
      end
    end
    if file.blank? || file == 'routes'
      Rails.logger.info("Importing data from #{path}routes.txt")
      CSV.foreach("#{path}routes.txt", headers: true) do |row|
        ::Route.create!(
          app:,
          gtfs_route_id: row['route_id'],
          agency: ::Agency.find_by(gtfs_agency_id: row['agency_id']),
          route_short_name: row['route_short_name'],
          route_long_name: row['route_long_name'],
          route_desc: row['route_desc'],
          route_type: row['route_type'].presence&.to_i,
          route_url: row['route_url'],
          route_color: row['route_color'],
          route_text_color: row['route_text_color'],
          route_sort_order: row['route_sort_order'],
          continuous_pickup: row['continuous_pickup'].presence&.to_i,
          continuous_drop_off: row['continuous_drop_off'].presence&.to_i,
          gtfs_network_id: row['network_id']
        )
      end
    end
    if file.blank? || file == 'shapes'
      Rails.logger.info("Importing data from #{path}shapes.txt")
      CSV.foreach("#{path}shapes.txt", headers: true) do |row|
        ::Shape.create!(
          app:,
          gtfs_shape_id: row['shape_id'],
          shape_pt_sequence: row['shape_pt_sequence'],
          shape_dist_traveled: row['shape_dist_traveled']
        ).set_lon_lat(
          lon: row['shape_pt_lon'],
          lat: row['shape_pt_lat']
        ).save!
      end
    end
    if file.blank? || file == 'stops'
      Rails.logger.info("Importing data from #{path}stops.txt")
      CSV.foreach("#{path}stops.txt", headers: true) do |row|
        ::Stop.create!(
          app:,
          gtfs_stop_id: row['stop_id'],
          stop_code: row['stop_code'],
          stop_name: row['stop_name'],
          tts_stop_name: row['tts_stop_name'],
          stop_desc: row['stop_desc'],
          gtfs_zone_id: row['zone_id'],
          stop_url: row['stop_url'],
          location_type: row['location_type'],
          parent_station: ::Stop.find_by(gtfs_stop_id: row['parent_station']),
          stop_timezone: row['stop_timezone'],
          wheelchair_boarding: row['wheelchair_boarding'],
          gtfs_level_id: row['level_id'],
          platform_code: row['platform_code']
        ).set_lon_lat(
          lon: row['stop_lon'],
          lat: row['stop_lat']
        ).save!
      end
    end
    if file.blank? || file == 'trips'
      Rails.logger.info("Importing data from #{path}trips.txt")
      CSV.foreach("#{path}trips.txt", headers: true) do |row|
        ::Trip.create!(
          app:,
          gtfs_trip_id: row['trip_id'],
          route: ::Route.find_by(gtfs_route_id: row['route_id']),
          service: ::Calendar.find_by(gtfs_service_id: row['service_id']) || ::CalendarDate.find_by(gtfs_service_id: row['service_id']),
          trip_headsign: row['trip_headsign'],
          trip_short_name: row['trip_short_name'],
          direction: row['direction_id'].presence&.to_i,
          block_id: row['block_id'],
          shape: ::Shape.find_by(gtfs_shape_id: row['shape_id']),
          wheelchair_accessible: row['wheelchair_accessible'].presence&.to_i,
          bikes_allowed: row['bikes_allowed'].presence&.to_i
        )
      end
    end
    if file.blank? || file == 'stop_times'
      Rails.logger.info("Importing data from #{path}stop_times.txt")
      CSV.foreach("#{path}stop_times.txt", headers: true) do |row|
        ::StopTime.create!(
          app:,
          trip: ::Trip.find_by(gtfs_trip_id: row['trip_id']),
          stop: ::Stop.find_by(gtfs_stop_id: row['stop_id']),
          arrival_time: ::StopTime.duration_from_time_string(row['arrival_time']).to_i,
          departure_time: ::StopTime.duration_from_time_string(row['departure_time']).to_i,
          stop_sequence: row['stop_sequence'].to_i,
          stop_headsign: row['stop_headsign'],
          pickup_type: row['pickup_type'].presence&.to_i || 0,
          drop_off_type: row['drop_off_type'].presence&.to_i || 0,
          continuous_pickup: row['continuous_pickup'].presence&.to_i || 1,
          continuous_drop_off: row['continuous_drop_off'].presence&.to_i || 1,
          shape_dist_traveled: row['shape_dist_traveled'],
          timepoint: row['timepoint']
        )
      end
    end
  end
end
