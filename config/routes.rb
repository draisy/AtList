Rails.application.routes.draw do

  root 'roots#index'

  resources :users do 
    resources :lists
  end 

  resources :lists do 
    resources :favorites
  end 

  resources :categories do 
    resources :lists
  end 

  resources :users

  get '/search' => 'searches#index', :as => :search
  # resources :favorites

  get '/auth/:provider/callback' => 'sessions#create', :as => :auth_login

  get '/logout' => 'sessions#destroy', :as => :logout

  get '/poke/:id' => 'favorites#poke', :as => :poke
  get '/relist/:id' => 'favorites#relist', :as => :relist
  get '/main' => 'roots#main', :as => :main
  get '/what_we_do' => 'roots#what_we_do', :as => :what_we_do
  get '/team' => 'roots#team', :as => :team
  get '/contact' => 'roots#contact', :as => :contact


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
