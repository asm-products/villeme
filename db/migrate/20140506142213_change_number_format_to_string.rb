class ChangeNumberFormatToString < ActiveRecord::Migration
  def change
  	change_column :places, :number, :string
  	change_column :events, :number, :string
  end
end
