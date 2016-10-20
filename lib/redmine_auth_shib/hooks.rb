module Redmine::AuthShib
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_account_login_top, :partial => 'redmine_auth_shib/view_account_login_top'
  end
end
