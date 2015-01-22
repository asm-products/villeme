class AddedGlobalizeToWeeks < ActiveRecord::Migration
  def self.up
    Week.create_translation_table!({
                                          :name => :string
                                      }, {
                                          :migrate_data => true
                                      })
  end

  def self.down
    Week.drop_translation_table! :migrate_data => true
  end
end
