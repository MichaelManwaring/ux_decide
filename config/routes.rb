Rails.application.routes.draw do
  get 'options/new'

  get 'options/create'

  get 'options/edit'

  get 'options/update'

  get 'options/destroy'

  get 'votes/new'

  get 'votes/create'

  get 'votes/edit'

  get 'votes/update'

  get 'votes/destroy'

  get 'preferences/new'

  get 'preferences/create'

  get 'preferences/edit'

  get 'preferences/update'

  get 'arbiters/new'

  get 'arbiters/create'

  get 'arbiters/edit'

  get 'arbiters/update'

  get 'profile/new'

  get 'profile/create'

  get 'profile/update'

  get 'profile/show'

  get 'votes/create'

  get 'votes/update'

  get 'votes/destroy'

  get 'users/show'

  devise_for :users, controllers: { sessions: "users/sessions", omniauth_callbacks: 'omniauth_callbacks' }

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup


  root 'decisions#new'

  # devise_scope :user do
  #  get "signup", to: "devise/registrations#new"
  #  get "login", to: "devise/sessions#new"
  #  get "logout", to: "devise/sessions#destroy"
  # end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :decisions, :users

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
