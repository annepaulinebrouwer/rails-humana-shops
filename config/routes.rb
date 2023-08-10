Rails.application.routes.draw do
  root to: "pages#home"
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :shops, only: %i[show index create]
      resources :users, only: %i[show create]
    end
  end
end
