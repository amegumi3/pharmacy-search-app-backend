class Api::V1::ReportsController < ApplicationController
  before_action :authenticate_api_v1_user!, only: [:report_import]
  
  def index
  end

  def report_import
    Report.report_import(params[:file])
    head :created
  end
end
