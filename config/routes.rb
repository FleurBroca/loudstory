Rails.application.routes.draw do


  ActiveAdmin.routes(self)
  devise_for :users, :controllers => {
    :registrations => "auth/registrations",
    :invitations => 'auth/invitations'
  }

  resources :after_register

  scope '(:locale)', locale: /fr/ do

    root to: "home#index"

    get 'dashboards/index', path: 'dashboard'
    get 'dashboards/:team_id/:user_id', to: 'dashboards#team_user_dashboard', as: 'dashboard'

    resources :teams do
      resources :users, only:[] do
        member do
          delete :remove_from_team
        end
      end
    end
    resources :tracks

    resources :exercises do
      resources :sessions do
      end
    end

    resources :answers do
      resources :comments, only: [:index, :new, :create, :destroy]
    end



  end
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
