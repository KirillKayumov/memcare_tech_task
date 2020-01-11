Rails.application.routes.draw do
  namespace :v1 do
    resources :orders do
      resources :line_items
    end
  end
end
