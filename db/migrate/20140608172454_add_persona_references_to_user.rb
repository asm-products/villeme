class AddPersonaReferencesToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :persona, index: true 
    end  	
  end
end
