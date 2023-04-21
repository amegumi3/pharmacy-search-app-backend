class Api::V1::PharmaciesController < ApplicationController
  MAX_NUMBER = 20
  NEARBY_PHARMACY_NUMBER = 6

  def index
    case params[:state]
    when "周辺スポットから"
      pharmacy = Pharmacy.near(params[:word], 10).limit(MAX_NUMBER)
    when "薬局名から"
      pharmacy = Pharmacy.where("name LIKE ?", "%#{params[:word]}%").limit(MAX_NUMBER)
    when "住所から"
      pharmacy = Pharmacy.where("address LIKE ?", "%#{params[:word]}%").limit(MAX_NUMBER)
    end

    render json: pharmacy
  end

  def show
    pharmacy = Pharmacy.includes(:reports).find(params[:id])

    reports = pharmacy.reports
    date_created = pharmacy.pharmacy_reports.first&.date_created
    render json: { reports: reports, date_created: date_created, near_pharmacy: pharmacy.nearbys.limit(NEARBY_PHARMACY_NUMBER) }
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
