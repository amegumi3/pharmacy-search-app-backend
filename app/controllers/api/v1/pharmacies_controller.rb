class Api::V1::PharmaciesController < ApplicationController
  MAX_NUMBER = 20

  def index
    case params[:state]
    when "周辺スポットから"
      pharmacy = Pharmacy.near(params[:word]).limit(MAX_NUMBER)
    when "薬局名から"
      pharmacy = Pharmacy.where("name LIKE ?", "%#{params[:word]}%").limit(MAX_NUMBER)
    end

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

  def destroy_all
    Pharmacy.destroy_all
  end
end
