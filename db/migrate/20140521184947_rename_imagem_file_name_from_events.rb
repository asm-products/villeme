class RenameImagemFileNameFromEvents < ActiveRecord::Migration
  def change
  	rename_column :events, :imagem_file_name, :image_file_name
  end
end
