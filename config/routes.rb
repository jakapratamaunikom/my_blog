Rails.application.routes.draw do
  root 'articles#index'
  
  resources :articles, only: ['show', 'index']


  namespace :admin do
    get '/' => "main#index", as: 'root'
    
    resources :articles do
      get :toggle_published_status, on: :member
    end

    resource :setting, only: [''] do
      get  :portfolio
      post :edit_portfolio
    end
  end

end
