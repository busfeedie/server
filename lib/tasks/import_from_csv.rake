# frozen_string_literal: true
# typed: false

desc "Imports an agency's GTFS data from a CSV file"
task :import_from_csv, %i[csv_folder_name app_id file agency_id] => :environment do |_t, args|
  require 'csv'
  app = ::App.find(args.app_id)
  path = "lib/data/#{args.csv_folder_name}/"
  file = args.file
  gtfs_agency_id = args.agency_id
  Rails.logger.info("csv_folder_name: #{args.csv_folder_name}, app_id: #{args.app_id}, file: #{args.file}, agency_id: #{args.agency_id}")
  ActiveRecord::Base.transaction do
    if file.blank? || file == 'agency'
      Rails.logger.info("Importing data from #{path}agency.txt")
      CSV.foreach("#{path}agency.txt", headers: true) do |row|
        next if gtfs_agency_id.present? && row['agency_id'] != gtfs_agency_id
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
    if file.blank? || file == 'routes'
      gtfs_route_ids = [].to_set
      Rails.logger.info("Importing data from #{path}routes.txt")
      CSV.foreach("#{path}routes.txt", headers: true) do |row|
        next if gtfs_agency_id.present? && row['agency_id'] != gtfs_agency_id
        gtfs_route_ids << row['route_id']
        ::Route.create!(
          app:,
          gtfs_route_id: row['route_id'],
          agency: ::Agency.find_by(gtfs_agency_id: row['agency_id'], app:),
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
    if file.blank? || file == 'trips'
      Rails.logger.info("Importing data from #{path}trips.txt")
      service_to_trip = {}
      shape_to_trip = {}
      trip_id_to_trip = {}
      trips = [].to_set
      CSV.foreach("#{path}trips.txt", headers: true) do |row|
        next if gtfs_agency_id.present? && !gtfs_route_ids.include?(row['route_id'])
        trip = ::Trip.new!(
          app:,
          gtfs_trip_id: row['trip_id'],
          route: ::Route.find_by(gtfs_route_id: row['route_id'], app:),
          service: ::Calendar.find_by(gtfs_service_id: row['service_id'],
                                      app:) || ::CalendarDate.find_by(
                                        gtfs_service_id: row['service_id'], app:
                                      ),
          trip_headsign: row['trip_headsign'],
          trip_short_name: row['trip_short_name'],
          direction: row['direction_id'].presence&.to_i,
          block_id: row['block_id'],
          shape: ::Shape.find_by(gtfs_shape_id: row['shape_id'], app:),
          wheelchair_accessible: row['wheelchair_accessible'].presence&.to_i,
          bikes_allowed: row['bikes_allowed'].presence&.to_i
        )
        trips << trip
        service_to_trip[row['service_id']] ||= []
        service_to_trip[row['service_id']] << trip
        shape_to_trip[row['shape_id']] ||= []
        shape_to_trip[row['shape_id']] << trip
      end
    end
    if file.blank? || file == 'calendar'
      Rails.logger.info("Importing data from #{path}calendar.txt")
      CSV.foreach("#{path}calendar.txt", headers: true) do |row|
        next if gtfs_agency_id.present? && service_to_trip[row['service_id']].blank?
        calendar = ::Calendar.create!(
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
        service_to_trip[row['service_id']]&.each do |trip|
          trip.service = calendar
        end
      end
    end
    if file.blank? || file == 'calendar_dates'
      Rails.logger.info("Importing data from #{path}calendar_dates.txt")
      CSV.foreach("#{path}calendar_dates.txt", headers: true) do |row|
        next if gtfs_agency_id.present? && service_to_trip[row['service_id']].blank?
        calendar_date = ::CalendarDate.create!(
          app:,
          calendar: ::Calendar.find_by(gtfs_service_id: row['service_id'], app:),
          gtfs_service_id: row['service_id'],
          date: row['date'],
          exception_type: row['exception_type'].presence&.to_i
        )
        service_to_trip[row['service_id']]&.service = calendar_date
      end
    end
    if file.blank? || file == 'shapes'
      Rails.logger.info("Importing data from #{path}shapes.txt")
      shapes = {}
      CSV.foreach("#{path}shapes.txt", headers: true) do |row|
        next if gtfs_agency_id.present? && shape_to_trip[row['shape_id']].blank?
        if shapes[row['shape_id']].present?
          shape = shapes[row['shape_id']]
        else
          shape = ::Shape.find_or_create_by(gtfs_shape_id: row['shape_id'], app:)
          shapes[row['shape_id']] = shape
          shape_to_trip[row['shape_id']]&.shape = shape
        end
        ::ShapePoint.new(
          app:,
          shape:,
          shape_pt_sequence: row['shape_pt_sequence'],
          shape_dist_traveled: row['shape_dist_traveled']
        ).set_lon_lat(
          lon: row['shape_pt_lon'],
          lat: row['shape_pt_lat']
        ).save!
        shape_to_trip[row['shape_id']]&.each do |trip|
          trip.shape = shape
        end
      end
    end
    if file.blank? || file == 'trips'
      trips.each do |trip|
        trip.save!
      end
    end
    if file.blank? || file == 'stop_times'
      Rails.logger.info("Importing data from #{path}stop_times.txt")
      trip_id_to_trip = ::Trip.where(app:).group_by(&:gtfs_trip_id) if gtfs_agency_id.blank?
      stop_to_stop_times = {}
      CSV.foreach("#{path}stop_times.txt", headers: true) do |row|
        next if gtfs_agency_id.present? && trip_id_to_trip[row['trip_id']].blank?
        stop_time = ::StopTime.new(
          app:,
          trip: trip_id_to_trip[row['trip_id']],
          stop: ::Stop.find_by(gtfs_stop_id: row['stop_id'], app:),
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
        stop_to_stop_times[row['stop_id']] ||= []
        stop_to_stop_times[row['stop_id']] << stop_time
      end
    end
    if file.blank? || file == 'stops'
      Rails.logger.info("Importing data from #{path}stops.txt")
      CSV.foreach("#{path}stops.txt", headers: true) do |row|
        next if gtfs_agency_id.present? && stop_to_stop_times[row['stop_id']].blank?
        stop = ::Stop.new(
          app:,
          gtfs_stop_id: row['stop_id'],
          stop_code: row['stop_code'],
          stop_name: row['stop_name'],
          tts_stop_name: row['tts_stop_name'],
          stop_desc: row['stop_desc'],
          gtfs_zone_id: row['zone_id'],
          stop_url: row['stop_url'],
          location_type: row['location_type'],
          parent_station: ::Stop.find_by(gtfs_stop_id: row['parent_station'], app:),
          stop_timezone: row['stop_timezone'],
          wheelchair_boarding: row['wheelchair_boarding'],
          gtfs_level_id: row['level_id'],
          platform_code: row['platform_code']
        ).set_lon_lat(
          lon: row['stop_lon'],
          lat: row['stop_lat']
        ).save!
        stop_to_stop_times[row['stop_id']].each do |stop_time|
          stop_time.stop = stop
        end
      end
    end
    if file.blank? || file == 'stop_times'
      stop_to_stop_times.each do |stop_id, stop_times|
        stop_times.each do |stop_time|
          stop_time.save!
        end
      end
    end
  end
end
