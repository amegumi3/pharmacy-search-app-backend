class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.string :name
      t.string :point
      t.boolean :basic

      t.timestamps
    end
  end
end
