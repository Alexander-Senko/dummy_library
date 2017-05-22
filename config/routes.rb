Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :requests, only: :index do
    collection do
      get ':scope', action: 'index', constraints: { scope: /active|expired/ }
    end
  end

  resources :books, shallow: true do
    collection do
      get ':scope', action: 'index', constraints: { scope: /available|borrowed|delayed/ }
    end

    resources :requests
  end
end
