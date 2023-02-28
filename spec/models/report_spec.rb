RSpec.describe Report, type: :model do
  describe "report_importメソッドのテスト" do
    let(:file_path) { "spec/fixtures/files/届出一覧表.xlsx" }
    let(:file) { fixture_file_upload(file_path, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") }

    before do
      Report.report_import(file)
    end

    it "ファイル内に記載されている届出の数だけデータを保存していること" do
      expect(Report.count).to eq 22
    end
    context "メソッドによってモデルにデータが保存された場合" do
      it "nameカラムには値が入っていること" do
        reports = Report.all
        reports.each do |report|
          expect(report.name).not_to eq(nil)
        end
      end

      it "pointカラムには点数が入っていること" do
        reports = Report.all
        reports.each do |report|
          expect(report.point).to end_with("点")
        end
      end

      it "ファイル内の調剤基本料をありにしているものについては、trueが入っていること" do
        reports = Report.all
        reports.each do |report|
          expect(report.basic).to eq(true) if report.id < 15
        end
      end

      it "ファイル内の調剤基本料をありにしているもの以外は、falseが入っていること" do
        reports = Report.all
        reports.each do |report|
          expect(report.basic).to eq(false) if report.id > 15
        end
      end
    end
  end
end
