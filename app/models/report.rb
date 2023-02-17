class Report < ApplicationRecord
  has_many :pharmacy_reports
  has_many :pharmacies, through: :pharmacy_reports

  def self.report_import(file)
    xlsx = Roo::Excelx.new(file.tempfile)
    xlsx.each_row_streaming(offset: 3) do |row|
      row[3].value == "あり" ? (base = true) : (base = false)

      report = Report.create(name: row[1].value, point: row[2], basic: base)
      report.update(feature: row[4].value) if row[4].present?
      report.update(case: row[5].value) if row[5].present?
    end
  end
end
