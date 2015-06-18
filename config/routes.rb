Rails.application.routes.draw do
  
  #############################
  # для мультиязычности нужно такой вот формат юзать
  # site.com/en/article
  #############################
  
  root 'articles#index'
  get "/about_me" => "pages#about_me", as: 'about_me'
  
  put '/switch_language' => "settings#switch_language", as: 'switch_language'

  resources :comments, only: [:create]
  resources :articles, only: [:show, :index] do
    get :preview, on: :member  
  end
  resources :tags, only: [] do
    put :mark, on: :member
  end

  resources :works, only: [:show, :index] do
    get :preview, on: :member  
  end
  
  namespace :admin do
    get '/' => "main#index", as: 'root'

    get  '/sign_in'    => 'sessions#new', as: 'sign_in'
    post '/sign_in'    => 'sessions#check'
    put  '/sign_out'   => 'sessions#out', as: 'sign_out'
      
    resources :images, only: [:create, :destroy]
    resources :tags

    resource :pride, only: [:show, :create]

    resources :articles do
      get :toggle_published_status, on: :member
    end
    
    resources :works do
      get :toggle_published_status, on: :member
    end

  end

end
