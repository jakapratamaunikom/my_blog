Rails.application.routes.draw do
  root 'articles#index'
  
  resources :articles, only: [:show, :index] do
    get :preview, on: :member  
  end
  get "/about_me" => "pages#about_me", as: 'about_me'


  namespace :admin do
    get '/' => "main#index", as: 'root'
    
    resources :articles do
      get :toggle_published_status, on: :member
    end

    resources :tags, only: [:index, :new, :create, :edit, :update, :destroy]

    resources :portfolios
  end

end
