Rails.application.routes.draw do
  root to: "pages#home"

  resources :shops, only: [:index]
end
