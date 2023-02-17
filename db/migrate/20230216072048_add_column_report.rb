class AddColumnReport < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :feature, :string
    add_column :reports, :case, :text
  end
end
