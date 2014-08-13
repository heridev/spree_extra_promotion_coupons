Spree::Core::Engine.routes.draw do
  namespace :api, :defaults => { :format => 'json' } do
    resources :option_values
  end
end

