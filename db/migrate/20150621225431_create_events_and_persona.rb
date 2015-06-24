class CreateEventsAndPersona < ActiveRecord::Migration
  def change
    create_table :events_personas, id: false do |t|
      t.belongs_to :event, index: true
      t.belongs_to :persona, index: true
    end
  end
end
