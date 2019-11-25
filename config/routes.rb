Rails.application.routes.draw do
  get 'populations', to: 'populations#index'
  get 'populations/by_year', to: 'populations#show', as: :populations_by_year
  get 'the_logz', to: 'population_inquiry_log_items#index', as: :logs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
