class RenameAdressColumnToPharmacies < ActiveRecord::Migration[6.1]
  def change
    rename_column :pharmacies, :adress, :address
  end
end
