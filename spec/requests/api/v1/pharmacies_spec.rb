RSpec.describe "Api::V1::Pharmacies", type: :request do
  describe "GET /index" do
    let!(:pharmacies_a) do
      create_list(:pharmacy, 21) do |pharmacy, i|
        pharmacy.name = "薬局名A-#{i}"
        pharmacy.save
      end
    end
    let!(:pharmacy_b) { create(:pharmacy, name: "薬局名B") }
    let(:pharmacies) { Pharmacy.all }

    context "params[:state]で「周辺スポットから」という言葉を受け取った場合" do
      before do
        # 周辺スポットからという言葉をエンコード
        state = "%E5%91%A8%E8%BE%BA%E3%82%B9%E3%83%9D%E3%83%83%E3%83%88%E3%81%8B%E3%82%89"
        # 新宿駅という言葉をエンコード
        word = "%E6%96%B0%E5%AE%BF%E9%A7%85"
        get "/api/v1/pharmacies?word=#{word}&state=#{state}", headers: headers
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

    context "params[:state]で「薬局名から」という言葉を受け取った場合" do
      before do
        # 薬局名からという言葉をエンコード
        state = "%E8%96%AC%E5%B1%80%E5%90%8D%E3%81%8B%E3%82%89"
        # 薬局名Aという言葉をエンコード
        word = "%E8%96%AC%E5%B1%80%E5%90%8DA"
        get "/api/v1/pharmacies?word=#{word}&state=#{state}", headers: headers
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

      it "取得した全ての薬局名に「薬局名A」ということばが入っていること" do
        json = JSON.parse(response.body)
        json.length do
          expect(json[i]["name"]).to include("薬局名A")
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
    let(:file_path) { "spec/fixtures/files/コード内容別一覧表（薬局）テスト.xlsx" }

    it "ステータスコード created を返すこと" do
      post "/api/v1/pharmacies/pharmacy_import", params: { file: fixture_file_upload(file_path) }
      expect(response).to have_http_status(:created)
    end
  end

  describe "POST /pharmacy_report_import" do
    let(:file_path) { "spec/fixtures/files/届出受理医療機関名簿（薬局）テスト.xlsx" }

    it "ステータスコード success を返すこと" do
      post "/api/v1/pharmacies/pharmacy_report_import", params: { file: fixture_file_upload(file_path) }
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE /api/v1/pharmacies/destroy_all" do
    let!(:report) { create(:report) }
    let!(:pharmacy_a) { create(:pharmacy, reports: [report]) }
    let!(:pharmacy_b) { create(:pharmacy) }
    before do
      delete "/api/v1/pharmacies/destroy_all"
    end
    it "Pharmacyモデルの値が空になっていること" do
      expect(Pharmacy.all).to eq([])
    end

    it "関連するPharmacyReportモデルの値も空になっていること" do
      expect(PharmacyReport.all).to eq([])
    end
  end
end
