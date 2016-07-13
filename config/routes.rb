Rails.application.routes.draw do


  #get 'cita/ver_citas'

  devise_for :rols
  devise_scope :rol do
  authenticated :rol do
    root 'cita#ver_citas', as: :authenticated_root
  end

  unauthenticated do
    root 'devise/sessions#new', as: :unauthenticated_root
  end
end

  get 'cita/borrarCita' => 'cita#borrarCita', :as => :borrarCita

  get 'cita/agendar' => 'cita#agendar', :as => :agendarCita

  get '/ver_citas' => 'cita#ver_citas'


  get 'cita/tomar_cita_esp' => 'cita#tomar_cita_esp', :as => :por_especialidad

  get '/tomar_cita_esp' => 'cita#tomar_cita_esp'
  get '/tomar_cita_med' => 'cita#tomar_cita_med'

  post '/' => 'cita#create'
  #root :to => "home#index"
  #root 'devise/sessions#new'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'devise/sessions#new'

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
