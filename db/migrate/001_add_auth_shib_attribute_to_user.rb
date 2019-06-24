class AddAuthShibAttributeToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :created_by_auth_shib, :boolean, default: false
  end
end
