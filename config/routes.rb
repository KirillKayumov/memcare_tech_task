Rails.application.routes.draw do
  namespace :v1 do
    resources :orders
  end
end
