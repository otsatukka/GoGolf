Gogolfrails::Application.routes.draw do
    
  resources :screams

  resources :videos do
      resources :comments, :only => [:create, :destroy] do
        member do
          post :vote_up
        end
        resources :replies, :only => [:create, :destroy]
      end
    end
  resources :shouts
  resources :bogey_counters

  resources :payment_notifications

  resources :deals
  resources :orders, :only => [:create, :destroy, :index, :show]

    #resources :groups
    resources :courses do
    	resources :course_datas
    	resources :bogey_counters
    end
    resources :categories
    resources :imagebanks
    
    scope "/admin" do
      match 'dashboard/index'
      match 'dashboard/posts'
      match 'dashboard/users'
      match 'dashboard/courses'
      match 'dashboard/links'
      match 'dashboard/openings'
      match 'dashboard/deals'
      match 'dashboard/videos'
    end
    match "refreshable" => "site#refreshable"
    match "login" => "site#login"
    resources :links do
      member do
        post :vote_up
      end
      resources :comments, :only => [:create, :destroy]
      collection do
        get "links"
        get "images"
        get "videos"
      end
    end

    devise_for :users, :controllers => { :registrations => "users" }

    resources :users do
        get :autocomplete_course_name, :on => :collection
      resources :rounds
      resources :events
      member do
        get "remove_account"
      end
      #resources :groups
      resources :orders, :only => [:index, :show, :create, :destroy]
    end

    #resources :groups do
    #  resources :memberships
    #end

    #resources :events do
    #    get :autocomplete_course_name, :on => :collection
    #  resources :users
    #  resources :attendances
    #end

    #match 'event/kaikki', :controller => 'events', :action => 'full_index'
    #match 'event/peliseura', :controller => 'events', :action => 'search'
    #match 'event/search_game_company', :controller => 'events', :action => 'game_company'

    #match 'groups/user_data', :controller=>'groups', :action=>'user_data'
    #match 'users/promote_to_group_admin', :controller=>'users', :action=>'promote_to_group_admin'

    resources :posts do
      resources :comments, :only => [:create, :destroy] do
        member do
          post :vote_up
        end
        resources :replies, :only => [:create, :destroy]
      end
    end
    
    resources :openings do
      resources :comments, :only => [:create, :destroy] do
        member do
          post :vote_up
        end
        resources :replies, :only => [:create, :destroy]
      end
    end

    match 'users/edit', :to => 'devise/registrations#edit'


    get "site/about"
    get "site/index"
    get "site/help"
    get "site/topic"
    get "site/guide"
    get "site/goproduct"
    get "site/yleiset_ehdot"
    get "site/verkkokaupan_ehdot"
    get "site/notuser"
    #get "attendances/create"
    #get "attendances/index"
    #get "attendances/destroy"
    #get "friendship/create"
    #get "friendship/accept"
    #get "friendship/decline"
    #resources :memberships, :collection => {:find=>:get}

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
