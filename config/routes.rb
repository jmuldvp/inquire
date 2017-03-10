Rails.application.routes.draw do
  get 'welcome/about'

  root 'welcome#index'

  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks" , registrations: "registrations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
