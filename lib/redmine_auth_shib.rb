module Redmine::AuthShib
  class << self

    def settings_hash
      Setting["plugin_redmine_auth_shib"]
    end

    def enabled?
      settings_hash["enabled"]
    end

    def onthefly_creation?
      enabled? && settings_hash["onthefly_creation"]
    end
  end

end
