Rails.application.routes.draw do
  root "lists#index"
  resources :lists, except: [:update, :edit] do
    resources :bookmarks, only: [:new, :create]
    resources :reviews, only: [:new, :create]
  end
  resources :bookmarks, only: [:destroy]
  resources :reviews, only: [:destroy]
end
