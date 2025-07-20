Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")

  get "home" => "home#index"
  get "home/getquery" => "home#getquery"
  get "home/passdatatoviews" => "home#passdatatoviews"
  get "home/showdatetimeinfo" => "home#showdatetimeinfo"
  get "home/conditional_rendering" => "home#conditional_rendering"
  get "home/loop_array" => "home#loop_array"
  get "home/fetch_users" => "home#fetch_users"
end
