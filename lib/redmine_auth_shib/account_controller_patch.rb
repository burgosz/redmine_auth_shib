require_dependency 'account_controller'

module Redmine::AuthShib
  module AccountControllerPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        alias_method_chain :login, :shib
        alias_method_chain :logout, :shib
      end
    end

    module InstanceMethods

      def login_with_shib
        #TODO: test 'replace_redmine_login' feature
        if shib_settings["enabled"] && shib_settings["replace_redmine_login"]
          redirect_to :controller => "account", :action => "login_with_shib_redirect", :provider => "shib", :origin => back_url
        else
          login_without_shib
        end

     end

      def login_with_shib_redirect
         auth = Hash.new
         auth["login"] = request.env["eppn"]
         auth["mail"] = request.env["mail"]
         auth["entitlement"] = request.env["entitlement"]
         auth["givenname"] = request.env["givenname"]
         auth["surname"] = request.env["surname"]
         user = User.login_or_create_from_shib(auth)
         successful_authentication(user)
      end
      def shib_settings
        Redmine::AuthShib.settings_hash
      end
def logout_with_shib

logout_without_shib
end

end
end
end

unless AccountController.included_modules.include? Redmine::AuthShib::AccountControllerPatch
  AccountController.send(:include, Redmine::AuthShib::AccountControllerPatch)
  AccountController.skip_before_filter :verify_authenticity_token, :only => [:login_with_shib_callback]
end