class RenameCaseFeatureColumnToReports < ActiveRecord::Migration[6.1]
  def change
    rename_column :reports, :feature, :report_feature
    rename_column :reports, :case, :calc_case
  end
end
