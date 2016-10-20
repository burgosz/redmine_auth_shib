require_dependency 'account_helper'

module Redmine::AuthShib
  module AccountHelperPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
      end
    end

    module InstanceMethods
      def label_for_shib_login
        Redmine::AuthShib.label_login_with_shib.presence || l(:label_login_with_shib)
      end
    end
  end
end

unless AccountHelper.included_modules.include? Redmine::AuthShib::AccountHelperPatch
  AccountHelper.send(:include, Redmine::AuthShib::AccountHelperPatch)
end
