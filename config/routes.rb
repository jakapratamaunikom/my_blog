Rails.application.routes.draw do
  
  root 'articles#index'
  get "/about_me" => "pages#about_me", as: 'about_me'
  
  resources :comments, only: [:create]
  resources :articles, only: [:show, :index] do
    get :preview, on: :member  
  end

  resources :my_works, only: [:show, :index] do
    get :preview, on: :member  
  end
  

  namespace :admin do
    get '/' => "main#index", as: 'root'
    
    resources :articles do
      get :toggle_published_status, on: :member
    end

    resources :tags

    resources :portfolios
  end

end
