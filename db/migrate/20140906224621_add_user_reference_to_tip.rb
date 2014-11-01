class AddUserReferenceToTip < ActiveRecord::Migration
  def change
    add_reference :tips, :user, index: true
  end
end
