Rails.application.routes.draw do
  devise_for :users, only: []
  get 'statistics', to: 'analyze_data#statistics'
	get 'correlations', to: 'analyze_data#correlations'
	resource :login, only: [:create], controller: :sessions
	resources :users, only: [:create]
end
