class RenameLongtitudeColumnToPharmacies < ActiveRecord::Migration[6.1]
  def change
    rename_column :pharmacies, :longtitude, :longitude
  end
end
