Rails.application.routes.draw do

  get '/search', to: 'searches#search'

  get '/measure', to: 'measures#measure'

  resources :past_plans, only: [:index, :show, :create, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
