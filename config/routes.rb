Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create edit update destory]
      post '/login' => 'sessions#create', as: 'login'
      get '/get_current_user' => 'sessions#get_current_user'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
