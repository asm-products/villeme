class RoolBackNotify < ActiveRecord::Migration
  def change
    change_column :notifies, :bell_view, :datetime
    change_column :notifies, :newsfeed_view, :datetime
    change_column :notifies, :persona_view, :datetime
    change_column :notifies, :neighborhood_view, :datetime
    change_column :notifies, :agenda_view, :datetime
    change_column :notifies, :category_view, :datetime  	
  end  	
end
