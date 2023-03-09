RSpec.describe PharmacyReport, type: :model do
  describe "pharmacy_importメソッドのテスト" do
    let!(:pharmacy_a) { create(:pharmacy, name: "薬局名A") }
    let!(:pharmacy_b) { create(:pharmacy, name: "薬局名B", tel: "012-345-6780") }
    let!(:report_a) { create(:report) }
    let!(:report_b) { create(:report, name: "かりつけ薬剤師指導料") }
    let!(:report_c) { create(:report, name: "かかりつけ薬剤師包括管理料") }

    let(:file_path) { "spec/fixtures/files/届出受理医療機関名簿（薬局）テスト.xlsx" }
    let(:file) { fixture_file_upload(file_path, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") }

    before do
      PharmacyReport.pharmacy_report_import(file)
    end

    it "Reportモデルに保存されている届出名と一致するデータの個数分保存していること" do
      expect(pharmacy_a.pharmacy_reports.count).to eq 1
      expect(pharmacy_b.pharmacy_reports.count).to eq 2
    end

    it "date_createdカラムに値が入っていること" do
      pharmacy_b.pharmacy_reports.each do |pharmacy_report|
        expect(pharmacy_report.date_created.empty?).to be false
      end
    end
  end
end
