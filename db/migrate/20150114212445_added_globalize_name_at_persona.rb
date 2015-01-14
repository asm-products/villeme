class AddedGlobalizeNameAtPersona < ActiveRecord::Migration
  def self.up
    Persona.create_translation_table!({
                                           :name => :string
                                       }, {
                                           :migrate_data => true
                                       })
  end

  def self.down
    Persona.drop_translation_table! :migrate_data => true
  end
end
