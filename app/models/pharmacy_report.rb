class PharmacyReport < ApplicationRecord
  belongs_to :pharmacy
  belongs_to :report

  def self.pharmacy_report_import(file)
    xlsx = Roo::Excelx.new(file.tempfile)
    date_created = xlsx.cell(2, 1).slice(1..8)
    xlsx.each_row_streaming(offset: 3) do |row|
      next if Pharmacy.find_by(tel: row[10].value).blank?
      next if row[3].value != "薬局"
      next if row[13].blank?
      # 調剤報酬点数表に記載されているもの以外は除く
      next if row[13].value.in?(["薬剤名等省略", "酸素の購入単価", "無菌製剤処理料"])
      pharmacy_id = Pharmacy.find_by(tel: row[10].value).id
      if row[13].value == "かかりつけ薬剤師指導料及びかかりつけ薬剤師包括管理料"
        PharmacyReport.create(date_created: date_created, pharmacy_id: pharmacy_id, report_id: Report.find_by(name: "かりつけ薬剤師指導料").id)
        PharmacyReport.create(date_created: date_created, pharmacy_id: pharmacy_id,
                              report_id: Report.find_by(name: "かかりつけ薬剤師包括管理料").id)
      else
        report_id = Report.find_by(name: row[13].value).id
        PharmacyReport.create(date_created: date_created, pharmacy_id: pharmacy_id, report_id: report_id)
      end
    end
  end
end
