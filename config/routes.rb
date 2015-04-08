Rails.application.routes.draw do
  root 'main#index'
  
  namespace :admin do
    get '/' => "main#index", as: 'root'
    resources :articles
  end

end
