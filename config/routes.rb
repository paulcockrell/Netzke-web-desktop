NetzkeTaskManager::Application.routes.draw do
  get "embedded_components/index"

  root :to => "application#index"
  
  match 'components/:component' => 'components#index', :as => "components"
  match 'components/embedded/:action' => 'components', :as => "embedded_components"

  match ':controller(/:action(/:id(.:format)))'

  netzke
end
