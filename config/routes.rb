Rails.application.routes.draw do
  get '/' => 'links#index'
  get '/about' => 'application#about'
  get '/new' => 'links#new'
  get '/:search' => 'links#search'
  post '/link' => 'links#create'
  resources :links
end
