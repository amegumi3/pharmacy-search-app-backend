class ChangePharmacyToLongtitude < ActiveRecord::Migration[6.1]
  def change
    change_column :pharmacies, :longtitude, :float
  end
end
