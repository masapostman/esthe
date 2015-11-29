Rails.application.routes.draw do
  config = Rails.application.config.esthe

  constraints host: config[:staff][:host] do
    namespace :staff ,path: config[:staff][:path] do
      root 'top#index'
      get 'login' => 'sessions#new', as: :login
      #post 'session' => 'sessions#create', as: :session
      #delete 'session' => 'sessions#destroy'

      resource :session, only:[ :create, :destroy]

      resource :account

      resource :password, only: [ :show, :edit, :update]

      resources :customers

      resources :customers ,only: [:index] do
         member { get :print}
      end

        resources :companies do
        resources :companies, only: [:index]
      end

      resources :loanorders

      resources 'loanorders', only: [:index] do
        collection { post :import }
      end

      resources :import_logs, only: [:index]

    end
  end

  constraints host: config[:customer][:host] do
    namespace :customer ,path: config[:customer][:path] do
      #root 'top#index'

      #root 'session#new', as: :login

      get 'login' => 'sessions#new', as: :login
      get 'session' => 'sessions#destroy'
      resource :session, only: [ :create, :destroy]

      resource :customer do
        patch :confirm
      end

      resources :loanorders, only:[ :index]

      resources :loanorders, only:[ :index] do
        collection { get :search}
      end

      resource :password,only: [:show, :edit, :update]
    end
  end

  constraints host: config[:admin][:host] do
    namespace :admin , path: config[:admin][:path] do
      root 'top#index'
      get 'login' => 'sessions#new', as: :login
      post 'session' => 'sessions#create', as: :session
      delete 'session' => 'sessions#destroy'
      resource :session, only:[ :create, :destroy]
      get 'customers/update_stores', as: 'update_stores'

      resources :staff_members do
        resources :staff_events, only: [:index]
      end
      resources :staff_events, only: [:index]

      resources :customers

      resources :customers ,only: [:index] do
         member { get :print}
      end

      resources :companies do
        resources :companies, only: [:index]
      end


      resources :loanorders

      resources 'loanorders', only: :index do
            collection { post :import }
      end

      resources :import_logs, only: [:index]
    end
  end

    root 'errors#not_found'

    get '*anything' => 'errors#not_found'

    

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
