Rails.application.routes.draw do
  root 'articles#index'
  
  resources :articles, only: ['show', 'index']

  namespace :admin do
    get '/' => "main#index", as: 'root'
    resources :articles
  end

end
