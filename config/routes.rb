Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount_devise_token_auth_for 'User', at: 'auth', controllers: { registrations: 'auth/registrations' }

  resources :messages, only: ['index'] do
    member do
      resources :likes, only: ['create']
    end
  end

  resources :likes, only: ['destroy']

end