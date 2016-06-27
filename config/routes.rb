Rails.application.routes.draw do
  resources :recipes
  root 'recipes#new'
end
