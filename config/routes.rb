Gogolfrails::Application.routes.draw do
  
  resources :groups
  
  resources :courses

  namespace :admin do
    resources :categories 
    match 'dashboard/index'
    match 'dashboard/posts'
    match 'dashboard/users'
    match 'dashboard/courses'
    match 'dashboard/links'
  end
  
  resources :links
  
  devise_for :users
  
  resources :users do
    resources :rounds
    resources :groups
  end
  
  resources :groups do
    resources :memberships
  end
  
  resources :events do
    resources :users
    resources :attendances do 
      get :autocomplete_user_email, :on => :collection
    end
  end
  
  match 'event/kaikki', :controller => 'events', :action => 'full_index'
  
  match 'groups/user_data', :controller=>'groups', :action=>'user_data'
  match 'users/promote_to_group_admin', :controller=>'users', :action=>'promote_to_group_admin'
  
  resources :posts
  
  match 'profiili', :to => 'profile#index'
  match 'users/edit', :to => 'devise/registrations#edit'
  
  get "friendship/create"
  get "friendship/accept"
  get "friendship/decline"
  get "site/about"
  get "site/index"
  get "site/help"
  get "attendances/create"
  get "attendances/index"
  get "attendances/destroy"
  resources :memberships, :collection => {:find=>:get}
  
  root :to => 'site#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
