class AddAuthShibToAuthSources < ActiveRecord::Migration
  def up
	AuthSource.create(name: "redmine_auth_shib", type: "AuthSourceShibboleth")
  end
end
