Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'signup'
  }
  root to:"prototypes#index"
  resources :prototypes
  resources :prototypes do
    resources :comments, only: :create
  end
  resources :users , only: :show
end
