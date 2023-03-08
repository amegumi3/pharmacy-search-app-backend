class AddColumnPharmayReports < ActiveRecord::Migration[6.1]
  def change
    add_column :pharmacy_reports, :cretated_day, :string
  end
end
