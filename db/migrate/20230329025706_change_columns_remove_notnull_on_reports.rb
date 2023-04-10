class ChangeColumnsRemoveNotnullOnReports < ActiveRecord::Migration[6.1]
  def change
    change_column :reports, :name, :string, null: true
    change_column :reports, :point, :string, null: true
  end
end
