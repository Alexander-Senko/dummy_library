Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :books do
    collection do
      get ':scope', action: 'index', constraints: { scope: /available|borrowed|delayed/ }
    end
  end
end
