RSpec.describe "Api::V1::Reports", type: :request do
  describe "POST /report_import" do
    let(:file_path) { "spec/fixtures/files/届出一覧表.xlsx" }

    it "ステータスコード sucess を返すこと" do
      post "/api/v1/reports/report_import", params: { file: fixture_file_upload(file_path) }
      expect(response).to have_http_status(:success)
    end

    describe "DELETE /api/v1/reports/destroy_all" do
      let!(:report) { create(:report) }
      let!(:pharmacy_a) { create(:pharmacy, reports: [report]) }
      let!(:pharmacy_b) { create(:pharmacy) }

      before do
        delete "/api/v1/reports/destroy_all"
      end
      it "Pharmacyモデルの値が空になっていること" do
        expect(Report.all).to eq([])
      end

      it "関連するPharmacyReportモデルの値も空になっていること" do
        expect(PharmacyReport.all).to eq([])
      end
    end
  end
end
