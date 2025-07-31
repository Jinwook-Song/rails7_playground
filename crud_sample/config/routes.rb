Rails.application.routes.draw do
  # 기존 sessions 관련 get 라우트 제거
  # get "sessions/new"
  # get "sessions/create"
  # get "sessions/destroy"

  # 사용자 관련 라우트
  get "signup", to: "users#new"
  post "signup", to: "users#create"

  # 세션(로그인/로그아웃) 관련 라우트
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "employees#index" # 또는 원하는 컨트롤러#액션으로 설정
  resources :employees do
    member do
      get :posts
    end
  end
end
