Rails.application.routes.draw do
  authenticated :user, -> user { user.admin? }  do
    mount DelayedJobWeb, at: "/delayed_job"
  end
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations:      'users/registrations'
  }

  namespace :admin do
    resources :users, param: :uuid
    resources :groups, param: :uuid
    resources :idols, param: :uuid

    root 'dashboard#index'
  end

  root 'home#index'
end
