class AddRouteToVariousModels < ActiveRecord::Migration
  def change
    add_column :users, :route, :string
    add_column :places, :route, :string
    add_column :events, :route, :string
  end
end
