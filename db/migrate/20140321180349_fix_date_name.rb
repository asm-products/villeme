class FixDateName < ActiveRecord::Migration
  def change
  	rename_column :events, :date, :date_start
  end
end
