class ChangeColumnsRemoveNotnullOnPharmacies < ActiveRecord::Migration[6.1]
  def change
    change_column :pharmacies, :postal_code, :string, null: true
    change_column :pharmacies, :address, :string, null: true
  end
end
