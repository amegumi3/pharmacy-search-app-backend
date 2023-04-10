class RenameCretatedDayColumnToPharmacyreports < ActiveRecord::Migration[6.1]
  def change
    rename_column :pharmacy_reports, :cretated_day, :date_created
  end
end
