RSpec.describe Pharmacy, type: :model do
  describe "pharmacy_importメソッドのテスト" do
    let(:file_path) { "spec/fixtures/files/コード内容別一覧表（薬局）テスト.xlsx" }
    let(:file) { fixture_file_upload(file_path, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") }
    let(:pharmacies) { Pharmacy.all }

    before do
      Pharmacy.pharmacy_import(file)
    end

    it "ファイル内に記載されている薬局の数だけデータを保存していること" do
      expect(Pharmacy.count).to eq 3
    end

    context "メソッドによってモデルにデータが保存された場合" do
      it "各カラムには期待する値が入っていること" do
        pharmacies.each do |pharmacy|
          expect(pharmacy.name).to include("薬局名")
          expect(pharmacy.postal_code).to include("〒")
          expect(pharmacy.address).to include("新宿区")
          expect(pharmacy.tel).to include("012-")
          expect(pharmacy.shuttered).to eq(true).or eq(false)
          expect(pharmacy.number).to eq(nil)
        end
      end

      it "postal_codeカラムは郵便番号のみであること" do
        pharmacies.each do |pharmacy|
          expect(pharmacy.postal_code).to start_with("〒")
          expect(pharmacy.postal_code.length).to eq(9)
          expect(pharmacy.postal_code).not_to include("新宿区")
        end
      end

      it "addressカラムの値は住所のみであること（郵便番号が入っていないこと）" do
        pharmacies.each do |pharmacy|
          expect(pharmacy.address).to start_with("新宿区")
          expect(pharmacy.address).not_to include("〒")
        end
      end
    end
  end
end
