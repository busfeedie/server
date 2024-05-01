# frozen_string_literal: true
# typed: false

RSpec.describe 'rake import_from_csv' do
  let(:app) { create(:app) }
  let(:app_id) { app.id }
  let(:csv_folder_name) { 'lib/data/gtfs/' }
  let(:subject) { Rake::Task['import_from_csv'] }

  before(:each) do
    subject.reenable
  end

  describe 'importing from a single file' do
    let(:import_from_file) { subject.invoke(csv_folder_name, app_id, file) }
    let(:run_file) do
      subject.reenable
      import_from_file
    end

    context 'importing only agencies' do
      let!(:file) { 'agency' }

      it 'creates agencies for each row' do
        run_file
        expect(Agency.count).to eq(2)
        agency = Agency.first
        expect(agency.app).to eq(app)
        expect(agency.gtfs_agency_id).to eq('7778198')
        expect(agency.agency_name).to eq('Mc Ginley Coach Travel')
        expect(agency.agency_url).to eq('http://www.johnmcginley.com/')
        expect(agency.agency_timezone).to eq('Europe/London')
        agency = Agency.last
        expect(agency.app).to eq(app)
        expect(agency.gtfs_agency_id).to eq('7778048')
        expect(agency.agency_name).to eq('Kearns Transport')
        expect(agency.agency_url).to eq('https://kearnstransport.com/')
        expect(agency.agency_timezone).to eq('Europe/London')
      end
    end

    context 'importing only stops' do
      let!(:file) { 'stops' }

      it 'creates stops for each row' do
        run_file
        expect(Stop.count).to eq(3)
        first = Stop.first
        expect(first.gtfs_stop_id).to eq('853000142')
        expect(first.stop_code).to eq('11262')
        expect(first.stop_name).to eq('Clonmany')
        expect(first.stop_desc).to eq(nil)
        expect(first.lat).to eq(55.2634881223568)
        expect(first.lon).to eq(-7.41347263603761)
        last = Stop.last
        expect(last.gtfs_stop_id).to eq('8530PB000300')
        expect(last.stop_code).to eq('601221')
        expect(last.stop_name).to eq('Lough Na Glack')
        expect(last.stop_desc).to eq('Bus')
        expect(last.lat).to eq(53.9709988711604)
        expect(last.lon).to eq(-6.70193802794857)
      end
    end

    describe 'importing only routes' do
      let(:file) { 'routes' }

      it 'creates routes for each row' do
        subject.invoke(csv_folder_name, app_id, 'agency')
        run_file
        expect(Route.count).to eq(2)
        route = Route.first
        expect(route.app).to eq(app)
        expect(route.agency.gtfs_agency_id).to eq('7778198')
        expect(route.route_short_name).to eq('932')
        expect(route.route_long_name).to eq("Crolly - Tourist Information O'Connell Street")
        expect(route.bus?).to eq(true)
        route = Route.last
        expect(route.app).to eq(app)
        expect(route.agency.gtfs_agency_id).to eq('7778198')
        expect(route.route_short_name).to eq('933')
        expect(route.route_long_name).to eq("Main Street Moville - Tourist Information O'Connell Street")
        expect(route.bus?).to eq(true)
      end
    end

    describe 'importing only calendar' do
      let(:file) { 'calendar' }

      it 'creates calendar for each row' do
        subject.invoke(csv_folder_name, app_id, 'agency')
        run_file
        expect(Calendar.count).to eq(3)
        calendar = Calendar.first
        expect(calendar.app).to eq(app)
        expect(calendar.gtfs_service_id).to eq('1')
        expect(calendar.start_date).to eq('2023-11-30'.to_date)
        expect(calendar.end_date).to eq('2024-03-29'.to_date)
        expect(calendar.monday?).to eq(true)
        expect(calendar.tuesday?).to eq(true)
        expect(calendar.wednesday?).to eq(true)
        expect(calendar.thursday?).to eq(true)
        expect(calendar.friday?).to eq(true)
        expect(calendar.saturday?).to eq(false)
        expect(calendar.sunday?).to eq(false)
        calendar = Calendar.last
        expect(calendar.app).to eq(app)
        expect(calendar.gtfs_service_id).to eq('14')
        expect(calendar.start_date).to eq('2023-11-30'.to_date)
        expect(calendar.end_date).to eq('2024-11-28'.to_date)
        expect(calendar.monday?).to eq(true)
        expect(calendar.tuesday?).to eq(true)
        expect(calendar.wednesday?).to eq(true)
        expect(calendar.thursday?).to eq(true)
        expect(calendar.friday?).to eq(false)
        expect(calendar.saturday?).to eq(false)
        expect(calendar.sunday?).to eq(false)
      end
    end

    describe 'importing only shapes' do
      let(:file) { 'shapes' }

      it 'creates trips for each row' do
        run_file
        expect(Shape.count).to eq(2)
        shape = Shape.first
        expect(shape.app).to eq(app)
        expect(shape.gtfs_shape_id).to eq('3290_2')
        expect(shape.shape_points.count).to eq(2)
        shape_point = shape.shape_points.first
        expect(shape_point.lat).to eq(55.0264754673466)
        expect(shape_point.lon).to eq(-8.26083637559889)
        expect(shape_point.shape_pt_sequence).to eq(1)
        expect(shape_point.shape_dist_traveled).to eq(0.0)
        shape = Shape.last
        expect(shape.app).to eq(app)
        expect(shape.gtfs_shape_id).to eq('3290_4')
        expect(shape.shape_points.count).to eq(2)
        shape_point = shape.shape_points.last
        expect(shape_point.lat).to eq(55.0269577995993)
        expect(shape_point.lon).to eq(-8.26079287669221)
        expect(shape_point.shape_pt_sequence).to eq(2)
        expect(shape_point.shape_dist_traveled).to eq(53.768)
      end
    end

    describe 'importing only trips' do
      let(:file) { 'trips' }

      before(:each) do
        subject.invoke(csv_folder_name, app_id, 'agency')
        subject.reenable
        subject.invoke(csv_folder_name, app_id, 'routes')
        subject.reenable
        subject.invoke(csv_folder_name, app_id, 'calendar')
        subject.reenable
        subject.invoke(csv_folder_name, app_id, 'shapes')
      end

      it 'creates trips for each row' do
        run_file
        expect(Trip.count).to eq(3)
        trip = Trip.first
        expect(trip.app).to eq(app)
        expect(trip.gtfs_trip_id).to eq('3290_1')
        expect(trip.route.gtfs_route_id).to eq('3290_36295')
        expect(trip.service.gtfs_service_id).to eq('14')
        expect(trip.trip_headsign).to eq("O'Connell Street, Dublin City")
        expect(trip.trip_short_name).to eq('3.Mo-Fr.13-932-y11-2')
        expect(trip.outbound?).to eq(true)
        expect(trip.shape.gtfs_shape_id).to eq('3290_2')
        trip = Trip.last
        expect(trip.app).to eq(app)
        expect(trip.gtfs_trip_id).to eq('3290_11')
        expect(trip.route.gtfs_route_id).to eq('3290_36295')
        expect(trip.service.gtfs_service_id).to eq('9')
        expect(trip.trip_headsign).to eq("O'Connell Street, Dublin City")
        expect(trip.trip_short_name).to eq('2.Sat.13-932-y11-2.1')
        expect(trip.outbound?).to eq(true)
        expect(trip.shape.gtfs_shape_id).to eq('3290_2')
      end
    end

    describe 'importing only stop_times' do
      let(:file) { 'stop_times' }

      before(:each) do
        subject.invoke(csv_folder_name, app_id, 'agency')
        subject.reenable
        subject.invoke(csv_folder_name, app_id, 'routes')
        subject.reenable
        subject.invoke(csv_folder_name, app_id, 'calendar')
        subject.reenable
        subject.invoke(csv_folder_name, app_id, 'shapes')
        subject.reenable
        subject.invoke(csv_folder_name, app_id, 'stops')
        subject.reenable
        subject.invoke(csv_folder_name, app_id, 'trips')
      end

      it 'creates stop_times for each row' do
        run_file
        expect(StopTime.count).to eq(3)
        first = StopTime.first
        expect(first.stop.gtfs_stop_id).to eq('853000142')
        expect(first.trip.gtfs_trip_id).to eq('3290_1')
        expect(first.arrival_time).to eq(16_200)
        expect(first.departure_time).to eq(16_200)
        expect(first.stop_sequence).to eq(1)
        expect(first.stop_headsign).to eq("O'Connell Street, Dublin City")
        expect(first.pickup_regular?).to eq(true)
        expect(first.drop_off_none?).to eq(true)
        expect(first.continuous_pickup_none?).to eq(true)
        expect(first.continuous_drop_off_none?).to eq(true)
        expect(first.shape_dist_traveled).to eq(nil)
        expect(first.timepoint).to eq(true)
        last = StopTime.last
        expect(last.stop.gtfs_stop_id).to eq('8530PB000300')
        expect(last.trip.gtfs_trip_id).to eq('3290_1')
        expect(last.arrival_time).to eq(17_700)
        expect(last.departure_time).to eq(17_700)
        expect(last.stop_sequence).to eq(3)
        expect(last.stop_headsign).to eq(nil)
        expect(last.pickup_regular?).to eq(true)
        expect(last.drop_off_regular?).to eq(true)
        expect(last.continuous_pickup_none?).to eq(true)
        expect(last.continuous_drop_off_none?).to eq(true)
        expect(last.shape_dist_traveled).to eq(nil)
        expect(last.timepoint).to eq(true)
      end
    end
  end

  describe 'importing a single agency from a multi-agency file' do
    let(:gtfs_agency_id) { '7778048' }
    let(:csv_folder_name) { 'lib/data/multi_agency/' }
    let(:import_from_file) { subject.invoke(csv_folder_name, app_id, '', gtfs_agency_id) }
    let(:run_file) do
      subject.reenable
      import_from_file
    end

    it 'imports data only for this agency' do
      run_file
      expect(Agency.count).to eq(1)
      agency = Agency.first
      expect(agency.app).to eq(app)
      expect(agency.gtfs_agency_id).to eq('7778048')
      expect(agency.agency_name).to eq('Kearns Transport')
      expect(Route.count).to eq(1)
      route = Route.first
      expect(route.agency).to eq(agency)
      expect(route.route_short_name).to eq('101')
      expect(Trip.count).to eq(1)
      trip = Trip.first
      expect(trip.route).to eq(route)
      expect(trip.gtfs_trip_id).to eq('12')
      expect(Stop.count).to eq(1)
      stop = Stop.first
      expect(stop.gtfs_stop_id).to eq('8530PB000300')
      expect(StopTime.count).to eq(1)
      stop_time = StopTime.first
      expect(stop_time.stop).to eq(stop)
      expect(stop_time.trip).to eq(trip)
      expect(Shape.count).to eq(1)
      shape = Shape.first
      expect(shape.gtfs_shape_id).to eq('7')
      expect(shape.shape_points.count).to eq(2)
      expect(ShapePoint.count).to eq(2)
      expect(trip.shape).to eq(shape)
      expect(Calendar.count).to eq(1)
      calendar = Calendar.first
      expect(calendar.gtfs_service_id).to eq('9')
      expect(trip.service).to eq(calendar)
    end
  end
end
