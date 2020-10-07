Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create edit update destory]
      post '/login' => 'sessions#create'
      get '/get_current_user' => 'sessions#render_current_user'
      delete '/logout' => 'sessions#destroy'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
