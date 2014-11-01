class RenameImagesColumnsFromPaperclip < ActiveRecord::Migration
  def change
  	rename_column :events, :imagem_content_type, :image_content_type
  	rename_column :events, :imagem_file_size, :image_file_size
 		rename_column :events, :imagem_updated_at, :image_updated_at
  end
end
