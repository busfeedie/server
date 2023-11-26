# typed: strict

class Api::LocationsController < ApplicationController
  extend ::T::Sig
  protect_from_forgery with: :null_session

  sig {returns(String)}
  def create
    factory = RGeo::Geographic.spherical_factory(srid: 4326)
    p = factory.point(params[:lat], params[:lon])
    position = ::VehiclePosition.create!(lonlat: p)
    render json: position
  end
end
