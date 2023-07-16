Rails.application.routes.draw do
  get 'reports/index', as: 'reports_index'
  get 'reports/report_by_category', as: 'reports_report_by_category'
  get 'reports/report_by_dates', as: 'reports_report_by_dates'
  get 'main/index'

  resources :categories
  resources :operations
  
  root 'main#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
