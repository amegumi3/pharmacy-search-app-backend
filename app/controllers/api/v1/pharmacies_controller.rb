class Api::V1::PharmaciesController < ApplicationController
  MAX_NUMBER = 20

  def index
    case params[:state]
    when "周辺スポットから"
      pharmacy = Pharmacy.near(params[:word]).limit(MAX_NUMBER)
    when "薬局名から"
      pharmacy = Pharmacy.where("name LIKE ?", "%#{params[:word]}%").limit(MAX_NUMBER)
    when "住所から"
      pharmacy = Pharmacy.where("address LIKE ?", "%#{params[:word]}%").limit(MAX_NUMBER)
    end

    render json: pharmacy
  end

  def show
    reports = Pharmacy.find(params[:id]).reports
    render json: reports
  end

  def pharmacy_import
    pharmacies = params[:files]
    pharmacies.each do |pharmacy|
      Pharmacy.pharmacy_import(pharmacy)
    end
    head :created
  end

  def pharmacy_report_import
    pharmacy_reports = params[:files]
    pharmacy_reports.each do |pharmacy_report|
      PharmacyReport.pharmacy_report_import(pharmacy_report)
    end
    head :created
  end

  def destroy_all
    Pharmacy.destroy_all
  end
end
