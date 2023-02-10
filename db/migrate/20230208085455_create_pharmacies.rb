class CreatePharmacies < ActiveRecord::Migration[6.1]
  def change
    create_table :pharmacies do |t|
      t.string :name, nul: false
      t.string :postal_code, null: false
      t.string :adress, null: false
      t.string :tel, nul:false
      t.boolean :shuttered, default: false, null: false
      t.float :latitude
      t.string :longtitude
      t.integer :number

      t.timestamps
    end
  end
end
