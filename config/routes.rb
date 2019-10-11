Rails.application.routes.draw do
  get 'populations', to: 'populations#index'
  get 'populations/by_year', to: 'populations#show'
  get 'logs', to: 'logs#index'
end
