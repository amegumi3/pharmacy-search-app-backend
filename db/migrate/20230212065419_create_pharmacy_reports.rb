class CreatePharmacyReports < ActiveRecord::Migration[6.1]
  def change
    create_table :pharmacy_reports do |t|
      t.references :pharmacy, null: false, foreign_key: true
      t.references :report, null: false, foreign_key: true

      t.timestamps
    end
  end
end
