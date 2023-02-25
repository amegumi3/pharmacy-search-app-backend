RSpec.describe "Api::V1::Reports", type: :request do
  describe "POST /report_import" do
    let!(:user) { create(:user) }
    let(:token) { user.create_new_auth_token }

    file_path = "spec/fixtures/files/コード内容別一覧表（薬局）テスト.xlsx"

    it "ログインしている場合は、ステータスコード success を返すこと" do
      post "/api/v1/reports/report_import", params: { file: fixture_file_upload(file_path) }, headers: token
      expect(response).to have_http_status(:success)
    end

    it "ログインしていない場合は、ステータスコード unauthorized を返すこと" do
      post "/api/v1/reports/report_import", params: { file: fixture_file_upload(file_path) }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
