# frozen_string_literal: true
# typed: false

module Admin
  # This controller is used to list the available trips
  class AppsController < Admin::AdminController
    extend ::T::Sig

    sig { void }
    def index
      @apps = T.let(App.all.to_a, T.nilable(T::Array[App]))
    end

    sig { void }
    def show
      @app = T.let(App.find_by(id: params[:id]), T.nilable(App))
      redirect_to action: 'index' unless @app
      flash.alert = 'App not found' unless @app
      render layout: 'admin/app'
    end

    sig { void }
    def create
      @app = T.let(App.create!, T.nilable(App))
      redirect_to action: 'show', id: @app.id if @app
      return if @app

      flash.alert = 'App not found'
      redirect_to action: 'index'
    end

    sig { void }
    def upload_gtfs
      @app = T.let(App.find_by(id: params[:id]), T.nilable(App))
      uploaded_file = T.let(params[:gtfs], T.nilable(ActionDispatch::Http::UploadedFile))
      return unless @app && uploaded_file

      filename = Rails.root.join('admin', 'uploads', uploaded_file.original_filename)
      File.open(filename, 'wb') do |file|
        file.write(uploaded_file.read)
      end
      folder_name = uploaded_file.original_filename.split('.').first
      folder_path = Rails.root.join('admin', 'uploads', folder_name)
      Dir.mkdir(folder_path) unless File.exist?(folder_path)
      files = []
      ::Zip::File.open(filename) do |zip_file|
        zip_file.each do |entry|
          Rails.logger.info "Extracting #{entry.name}"
          filename = Rails.root.join('admin', 'uploads', folder_name, entry.name)
          entry.extract(filename)
          files << filename
        end
      end
      Services::CsvImporter.new(csv_folder_name: folder_path, app: @app, file: '',
                                agency_id: params[:agency_id]).import!
      files.each { |file| File.delete(file) }
      redirect_to action: 'show', id: @app.id
    end
  end
end
