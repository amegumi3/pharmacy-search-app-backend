class ChangeColumnsAddNotnullOnReports < ActiveRecord::Migration[6.1]
  def change
    change_column :reports, :name, :string, null: false
    change_column :reports, :point, :string, null: false
  end
end
