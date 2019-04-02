require 'redmine'
require 'redmine_auth_shib'
require 'redmine_auth_shib/hooks'
require 'redmine_auth_shib/user_patch'


# Patches to existing classes/modules
ActiveSupport::Reloader.to_prepare do
  require_dependency 'redmine_auth_shib/account_helper_patch'
  require_dependency 'redmine_auth_shib/account_controller_patch'
end

# Plugin generic informations
Redmine::Plugin.register :redmine_auth_shib do
  name 'Redmine Shibboleth authentication plugin'
  description 'This plugin Shibboleth support to Redmine.'
  author 'Szabolcs Tenczer'
  author_url 'mailto:burgosz@sztaki.hu'
  url 'https://github.com/burgosz/redmine_auth_shib'
  version '1.0'
  requires_redmine :version_or_higher => '2.3.0'
  settings :default => { 'enabled' => 'true', 'replace_redmine_login' => false  },
           :partial => 'settings/auth_shib_settings'
end

