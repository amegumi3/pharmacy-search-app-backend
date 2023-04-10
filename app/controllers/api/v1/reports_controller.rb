class Api::V1::ReportsController < ApplicationController
  def report_import
    reports = params[:files]
    reports.each do |report|
      Report.report_import(report)
    end
    head :created
  end

  def destroy_all
    Report.destroy_all
  end
end
