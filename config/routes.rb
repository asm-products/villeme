CidadeVc::Application.routes.draw do

  resources :countries

  resources :states



  post '/rate' => 'rater#create', :as => 'rate'



  # Devise

  devise_for :users, :controllers => {:omniauth_callbacks => "omniauth_callbacks"}

  devise_scope :user do
    get 'sign_up', to: 'devise/registrations#new', as: :registrar
    get 'sign_in', to: 'devise/sessions#new', as: :entrar
    get 'sign_out', to: 'devise/sessions#destroy', as: :sair
    get 'account/edit', to: 'devise/registrations#edit', as: 'conta_edit'
  end


  scope "(:locale)", locale: /en|br/ do

    root to: 'welcome#index', as: :welcome

    resources :events do
      get :schedule, on: :member
    end

    # Account
    get 'user/:id/account', to: 'accounts#edit', as: :user_account
    match 'account/update/:id', to: 'accounts#update', via: :put, as: :account_update





    get "bussola/city"
    get "bussola/neighborhood"
    post "bussola/selecionado"


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


    # Notifications
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


    get 'user/:id/events', to: 'profiles#events', as: :user_events
    get 'user/:id/', to: 'users#show', as: :show_user

    # /city
    get 'city/:city/:neighborhood', to: 'newsfeed#index'
    get 'city/:city', to: 'newsfeed#index', as: :root
    get 'city/:city', to: 'newsfeed#default', as: :newsfeed_default


  end



  # AJAX ------------------------------------------
  
    # Complete description of event on show
    get 'events/:event/fulldescription', to: 'events#full_description', as: 'full_description'

    # Aprove event to newsfeed
    match 'events/aprove/:id', to: 'events#aprove', via: :put, as: 'event_aprove'
  
    # Friendship routes
    get "friendships/request", to: "friendships#request_friendship", as: :friend_request
    get "friendships/accept", to: "friendships#accept_friendship", as: :friend_accept
    get "friendships/destroy", to: "friendships#destroy_friendship", as: :friend_destroy

    # Send invite to users
    get 'invites/send/:key', to: 'invites#send_invite', as: 'send_invite'


    # Tips on events
    get "tips/create"
    get "tips/destroy"




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
