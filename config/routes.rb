RedmineApp::Application.routes.draw do
  match '/auth/failure'             => 'account#login_with_shib_failure',   via: [:get, :post]
  match '/auth/:provider/callback'  => 'account#login_with_shib_callback',  via: [:get, :post]
  match '/auth/:provider'           => 'account#login_with_shib_redirect',  as: :sign_in, via: [:get, :post]
end
