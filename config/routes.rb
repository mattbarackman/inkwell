Inkwell::Application.routes.draw do
  # match '/auth/:provider/callback' => 'authentications#create'
  devise_for :admins
  devise_for :users, :controllers => {:registrations => 'registrations'} do
    match "/users/auth/:provider/callback" => 'authentications#all'
  end

  

  # devise_scope :user do 
  #   get "/users/auth/:provider/callback" => 'devise/authentications#create'
  # end
  get '/friends/facebook' => 'friends#show_fb_friends'
  post '/friends/facebook' => 'friends#add_fb_friend', as: :add_fb_friend

  match '/profile' => 'users#profile', as: :user_root
  # match '/orders/associate_card' => 'orders#new_card', as: :associate_card
  match '/orders/associate_card' => 'orders#create_card', as: :associate_card, via: :post

  resources :authentications


  resources :friends, :only => [:index, :new, :create, :edit, :update, :destroy]

  get '/orders/js' => "orders#ajax_get"
  post '/orders/js' => "orders#ajax_post"
  resources :occasions

  resources :orders
  resources :cards
  resources :tags
  resources :photos
  resources :charges
  # The priority is based upon order of creation:
  # first created -> highest priority.
  root :to => 'cards#index'

  match '/admin/dashboard' => 'admins#index', as: :admin

  # resources :cardstags, :only => [:destroy]
  match '/cardstags' => 'cardstags#destroy'
  resources :cards, :only => [:index, :show, :update, :destroy]

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
