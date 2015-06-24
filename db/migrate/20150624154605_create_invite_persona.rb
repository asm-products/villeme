class CreateInvitePersona < ActiveRecord::Migration
  def change
    create_table :invites_personas, id: false do |t|
      t.belongs_to :invite, index: true
      t.belongs_to :persona, index: true
    end
  end
end
