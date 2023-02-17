class Api::V1::PharmaciesController < ApplicationController
  MAX_NUMBER = 20
  def index
    pharmacy = Pharmacy.near(params[:query]).limit(MAX_NUMBER)
    render json: pharmacy
  end

  def show
    reports = Pharmacy.find(params[:id]).reports
    render json: reports
  end

  def pharmacy_import
    Pharmacy.pharmacy_import(params[:file])
    head :created
  end

  def pharmacy_report_import
    PharmacyReport.pharmacy_report_import(params[:file])
    head :created
  end
end
