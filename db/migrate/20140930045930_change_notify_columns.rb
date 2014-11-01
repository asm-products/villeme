class ChangeNotifyColumns < ActiveRecord::Migration
  def change
    change_column :notifies, :bell_view, :date
    change_column :notifies, :newsfeed_view, :date
    change_column :notifies, :persona_view, :date
    change_column :notifies, :neighborhood_view, :date
    change_column :notifies, :agenda_view, :date
    change_column :notifies, :category_view, :date  	
  end
end
