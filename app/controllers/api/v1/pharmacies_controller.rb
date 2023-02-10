class Api::V1::PharmaciesController < ApplicationController
  def index
    pharmacy = Pharmacy.near("大宮駅", 0.3)
    render json: pharmacy
  end

  def import
    Pharmacy.import(params[:file])
    head :created
  end
end
