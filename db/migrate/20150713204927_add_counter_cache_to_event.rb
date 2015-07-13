class AddCounterCacheToEvent < ActiveRecord::Migration
  def change
    add_column :events, :agendas_count, :integer, default: 0
  end
end
