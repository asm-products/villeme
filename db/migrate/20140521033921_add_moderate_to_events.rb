class AddModerateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :moderate, :integer
  end
end
