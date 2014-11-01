class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.text :description
      t.references :event, index: true

      t.timestamps
    end
  end
end
