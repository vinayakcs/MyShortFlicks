Rails.application.routes.draw do


  get 'system/privacy_policy'

  match '/auth/:provider', :to => 'sessions#omniauth_create',  via: [:post, :get]
  match '/auth/failure', :to => 'sessions#omniauth_failure',  via: [:post, :get]
  match "/signout" , :to => 'sessions#destroy', :as => :signout, via: [:post, :get]
  match "/privacy", :to => 'system#privacy_policy', :as => :privacy, via: [:get]
  match "/terms", :to => 'system#terms_of_service', :as => :terms, via: [:get]

  root :to => "videos#index", via: [:post, :get]
  resources :videos do
   resources :comments, only: [:destroy,:create], via: [:post,:get]
  end
  resources :channels
  resources :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
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
