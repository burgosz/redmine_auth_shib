class AddAuthShibAttributeToUser < ActiveRecord::Migration
  def change
    add_column :users, :created_by_auth_shib, :boolean, default: false
  end
end