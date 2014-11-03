CidadeVc::Application.routes.draw do




    get "tips/create"
    get "tips/destroy"


    post '/rate' => 'rater#create', :as => 'rate'
    

    # URL BASE -------------------------

      # root direciona para o controller newsfeed
      get '/newsfeed', to: "newsfeed#index", via: :get, as: :root    
     
      # root para o index
      root to: 'welcome#index', as: :welcome

      # /events com link para agendar via /schedule
      resources :events do
        get :schedule, on: :member
      end


      get "bussola/city"
      get "bussola/neighborhood"
      post "bussola/selecionado"


    # Devise
    
      devise_for :users, :controllers => {:omniauth_callbacks => "omniauth_callbacks"}

      devise_scope :user do
        get 'sign_up', to: 'devise/registrations#new', as: :registrar
        get 'sign_in', to: 'devise/sessions#new', as: :entrar
        get 'sign_out', to: 'devise/sessions#destroy', as: :sair
        get 'account/edit', to: 'devise/registrations#edit', as: 'conta_edit'
      end


    # Profiles
    
      # :id/events
      get ':id/events', to: 'profiles#events', as: :user_events



    # Account
    
      # :id/account
      get ':id/account', to: 'accounts#edit', as: :user_account

      match 'account/update/:id', to: 'accounts#update', via: :put, as: :account_update



    # Newsfeed
    
      # /
      get 'newsfeed',  to: 'newsfeed#index', as: :newsfeed

      # /mypersona -> filtra os eventos pela persona do current_user
      get 'mypersona/', to: 'newsfeed#mypersona', as: :my_persona_events

      # /category/:category -> filtra os eventos por categoria
      get 'category/:category/', to: 'newsfeed#index', as: :newsfeed_category

      # /neighborhood/events -> filtra os eventos por bairro
      get 'neighborhood/:neighborhood/', to: 'newsfeed#index', as: :newsfeed_neighborhood 

      # /myneighborhood -> filtra os eventos por bairro para o current_user
      get 'myneighborhood/', to: 'newsfeed#myneighborhood', as: :my_neighborhood_events   

      # /myagenda -> filtra os eventos da minha agenda
      get 'myagenda/', to: 'newsfeed#myagenda', as: :my_agenda_events     


    # Notificações

      get "notify/bell"
      get "notify/newsfeed"



    resources :subcategories

    resources :categories

    resources :cities

    resources :neighborhoods

    resources :places

    resources :levels    

    resources :users, except: :show

    resources :invites

    resources :weeks

    resources :prices

    # /feedback
    resources :feedbacks

    # /persona
    resources :personas

    resources :tips

  # AJAX ------------------------------------------
  
    # Descrição completa em "event#show"
    get 'events/:event/fulldescription', to: 'events#full_description', as: 'full_description'

    # Aprova evento para o newsfeed pelo admin
    match 'events/aprove/:id', to: 'events#aprove', via: :put, as: 'event_aprove'
  
    # Urls de gerenciamento de amizades
    get "friendships/request", to: "friendships#request_friendship", as: :friend_request
    get "friendships/accept", to: "friendships#accept_friendship", as: :friend_accept
    get "friendships/destroy", to: "friendships#destroy_friendship", as: :friend_destroy

    # Envia convite para usuarios
    get 'invites/send/:key', to: 'invites#send_invite', as: 'send_invite'

    get ':id/', to: 'users#show', as: :show_user


  # torna possivel "redirects" para root_path
  # root :controller => 'static', :action => '/' 

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
