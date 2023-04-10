class ChangeColumnsAddNotnullOnPharmacies < ActiveRecord::Migration[6.1]
  def change
    change_column :pharmacies, :name, :string, default: "名称不明", null: false
  end
end
