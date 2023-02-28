RSpec.describe "Api::V1::Pharmacies", type: :request do
  describe "GET /index" do
    let!(:pharmacies) { create_list(:pharmacy, 25) }

    before do
      # 新宿駅という言葉をエンコード
      word = "%E6%96%B0%E5%AE%BF%E9%A7%85"
      get "/api/v1/pharmacies?query=#{word}", headers: headers
    end

    it "ステータスコード success を返すこと" do
      expect(response).to have_http_status(:success)
    end

    it "コントローラーで設定した定数分、情報を受け取ること" do
      json = JSON.parse(response.body)
      pharmacies.each_with_index do |pharmacy, i|
        if i < (Api::V1::PharmaciesController::MAX_NUMBER)
          expect(json[i]["id"]).to eq(pharmacy.id)
          expect(json[i]["name"]).to eq(pharmacy.name)
          expect(json[i]["tel"]).to eq(pharmacy.tel)
          expect(json[i]["postal_code"]).to eq(pharmacy.postal_code)
          expect(json[i]["adress"]).to eq(pharmacy.adress)
          expect(json[i]["shuttered"]).to eq(pharmacy.shuttered)
        else
          expect(json[i]).to be nil
        end
      end
    end
  end

  describe "GET /show" do
    let(:report) { create(:report) }
    let(:pharmacy_a) { create(:pharmacy, reports: [report]) }
    let(:pharmacy_b) { create(:pharmacy) }

    it "ステータスコード success を返すこと" do
      get "/api/v1/pharmacies/#{pharmacy_a.id}"
      expect(response).to have_http_status(:success)
    end

    it "関連する基準が取得されていること" do
      get "/api/v1/pharmacies/#{pharmacy_a.id}"
      json = JSON.parse(response.body)
      expect(json[0]["id"]).to eq(report.id)
      expect(json[0]["name"]).to eq(report.name)
      expect(json[0]["point"]).to eq(report.point)
      expect(json[0]["basic"]).to eq(report.basic)
      expect(json[0]["report_feature"]).to eq(report.report_feature)
      expect(json[0]["calc_case"]).to eq(report.calc_case)
    end

    it "関連する基準が存在しない場合は、nilを返す" do
      get "/api/v1/pharmacies/#{pharmacy_b.id}"
      json = JSON.parse(response.body)
      expect(json[0]).to be nil
    end
  end

  describe "POST /pharmacy_import" do
    let!(:user) { create(:user) }
    let(:token) { user.create_new_auth_token }
    let(:file_path) { "spec/fixtures/files/コード内容別一覧表（薬局）テスト.xlsx" }

    it "ログインしている場合は、ステータスコード success を返すこと" do
      post "/api/v1/pharmacies/pharmacy_import", params: { file: fixture_file_upload(file_path) }, headers: token
      expect(response).to have_http_status(:success)
    end

    it "ログインしていない場合は、ステータスコード unauthorized を返すこと" do
      post "/api/v1/pharmacies/pharmacy_import", params: { file: fixture_file_upload(file_path) }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "POST /pharmacy_report_import" do
    let!(:user) { create(:user) }
    let(:token) { user.create_new_auth_token }
    let(:file_path) { "spec/fixtures/files/届出受理医療機関名簿（薬局）テスト.xlsx" }

    it "ログインしている場合は、ステータスコード success を返すこと" do
      post "/api/v1/pharmacies/pharmacy_report_import", params: { file: fixture_file_upload(file_path) }, headers: token
      expect(response).to have_http_status(:success)
    end

    it "ログインしていない場合は、ステータスコード unauthorized を返すこと" do
      post "/api/v1/pharmacies/pharmacy_report_import", params: { file: fixture_file_upload(file_path) }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
