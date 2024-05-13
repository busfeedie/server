# frozen_string_literal: true
# typed: false

desc "Imports an agency's GTFS data from a CSV file"
task :import_from_csv, %i[csv_folder_name app_id file agency_id] => :environment do |_t, args|
  require 'csv'
  app = ::App.find(args.app_id)
  Rails.logger.info(
    "csv_folder_name: #{args.csv_folder_name}, app_id: #{args.app_id}, file: #{args.file}, agency_id: #{args.agency_id}"
  )
  Services::CsvImporter.new(csv_folder_name: args.csv_folder_name, app:, file: args.file,
                            agency_id: args.agency_id).import!
end
