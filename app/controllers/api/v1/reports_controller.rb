class Api::V1::ReportsController < ApplicationController
  def index
  end

  def report_import
    Report.report_import(params[:file])
    head :created
  end

  def destroy_all
    Report.destroy_all
  end
end
