class PharmacyReport < ApplicationRecord
  belongs_to :pharmacy
  belongs_to :report

  def self.pharmacy_report_import(file)
    xlsx = Roo::Excelx.new(file.tempfile)
    xlsx.each_row_streaming(offset: 3) do |row|
      next if Pharmacy.find_by(tel: row[10].value).blank?
      next if row[3].value != "薬局"
      next if row[13].blank?
      # 直接算定に影響する届出のみ登録
      next if row[13].value.in?(["薬剤名等省略", "酸素の購入単価"])
      pharmacy_id = Pharmacy.find_by(tel: row[10].value).id
      if row[13].value == "かかりつけ薬剤師指導料及びかかりつけ薬剤師包括管理料"
        PharmacyReport.create(pharmacy_id: pharmacy_id, report_id: Report.find_by(name: "かりつけ薬剤師指導料").id)
        PharmacyReport.create(pharmacy_id: pharmacy_id, report_id: Report.find_by(name: "かかりつけ薬剤師包括管理料").id)
      else
        report_id = Report.find_by(name: row[13].value).id
        PharmacyReport.create(pharmacy_id: pharmacy_id, report_id: report_id)
      end
    end
  end
end
