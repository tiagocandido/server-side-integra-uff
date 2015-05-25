Rails.application.routes.draw do

  # Courses routes
  get ':system/courses' => 'courses#index'
  get ':system/courses/:id' => 'courses#show'

  # Events routes
  get ':system/courses/:course_id/events' => 'events#index'
  get ':system/courses/:course_id/events/:id' => 'events#show'

  # Events routes
  get ':system/courses/:course_id/topics' => 'topics#index'
  get ':system/courses/:course_id/topics/:id' => 'topics#show'

  # Authentication routes
  post ':system/authentication/login' => 'authentication#login'
  get ':system/authentication/validate' => 'authentication#validate'
  get ':system/authentication/logout' => 'authentication#logout'

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
