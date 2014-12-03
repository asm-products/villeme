class AddPersonaIdToEvent < ActiveRecord::Migration
  def change
    add_reference :events, :persona, index: true
  end
end
