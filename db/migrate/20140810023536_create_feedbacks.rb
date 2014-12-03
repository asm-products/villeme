class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.references :user, index: true
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
