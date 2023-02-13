class Api::V1::PharmaciesController < ApplicationController
  MAX_NUMBER = 20
  def index
    pharmacy = Pharmacy.near(params[:query]).limit(MAX_NUMBER)
    render json: pharmacy
  end

  def import
    Pharmacy.import(params[:file])
    head :created
  end

  def report_import
    PharmacyReport.report_import(params[:file])
    head :created
  end
end
