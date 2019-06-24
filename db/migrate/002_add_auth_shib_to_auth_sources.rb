class AddAuthShibToAuthSources < ActiveRecord::Migration[5.2]
  def up
	AuthSource.create(name: "redmine_auth_shib", type: "AuthSourceShibboleth")
  end
end
