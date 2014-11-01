class AddAttachmentImagemToEvents < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.attachment :imagem
    end
  end

  def self.down
    drop_attached_file :events, :imagem
  end
end
