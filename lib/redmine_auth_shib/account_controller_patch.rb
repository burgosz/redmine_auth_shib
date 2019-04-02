require_dependency 'account_controller'

module Redmine::AuthShib
  module AccountControllerPatch
      def login_with_shib_redirect
        auth = Hash.new
        auth["login"] = request.env["eppn"]
        auth["mail"] = request.env["mail"]
        auth["entitlement"] = request.env["entitlement"]
        if request.env["givenName"].nil?
		auth["givenName"] = "TBA"
	else
	        auth["givenName"] = request.env["givenName"]
	end
        if request.env["sn"].nil?
                auth["sn"] = "TBA"
        else
        	auth["sn"] = request.env["sn"]
        end
        begin
          user = User.login_or_create_from_shib(auth)
        rescue => error
          flash[:error] = l(error.message)
          redirect_to signin_url
          return
        end
	user.update_attribute(:last_login_on, Time.now)
        successful_authentication(user)
      end

    module InstanceMethods

      def login
        if shib_settings["enabled"] && shib_settings["replace_redmine_login"]
	  redirect_to :controller => "account", :action => "login_with_shib_redirect", :provider => "shib", :origin => back_url
        else
          login_without_shib
        end
	super

      end

      def shib_settings
        Redmine::AuthShib.settings_hash
      end

    end
  end
end

unless AccountController.included_modules.include? Redmine::AuthShib::AccountControllerPatch
  AccountController.send(:include, Redmine::AuthShib::AccountControllerPatch)
  AccountController.skip_before_action :verify_authenticity_token, :only => [:login_with_shib_callback]
end
