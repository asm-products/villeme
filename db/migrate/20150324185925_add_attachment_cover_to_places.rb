class AddAttachmentCoverToPlaces < ActiveRecord::Migration
  def self.up
    change_table :places do |t|
      t.attachment :cover
    end
  end

  def self.down
    drop_attached_file :places, :cover
  end
end
