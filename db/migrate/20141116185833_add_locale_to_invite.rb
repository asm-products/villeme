class AddLocaleToInvite < ActiveRecord::Migration
  def change
    add_column :invites, :locale, :string, default: "en"
  end
end
