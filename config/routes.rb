Rails.application.routes.draw do
  resources :clearance_batches, only: [:index, :create]
  resources :clearance_batch_report, only: [:show]
  resources :items, only: [:index]
  root to: "clearance_batches#index"
end
