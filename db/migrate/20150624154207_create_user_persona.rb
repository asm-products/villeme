class CreateUserPersona < ActiveRecord::Migration
  def change
    create_table :personas_users, id: false do |t|
      t.belongs_to :persona, index: true
      t.belongs_to :user, index: true
    end
  end
end
