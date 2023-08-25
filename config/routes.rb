Rails.application.routes.draw do
  root "lists#index"
  resources :lists, except: [:destroy, :update, :edit] do
    resources :bookmarks, only: [:new, :create]
  end
  resources :bookmarks, only: [:destroy]
end
