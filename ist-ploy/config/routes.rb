IstPloy::Application.routes.draw do

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

  resources :user_sessions
  resources :messages

  match 'login' => "user_sessions#new",      :as => :login
  match 'logout' => "user_sessions#destroy", :as => :logout

  resources :users  # give us our some normal resource routes for users
  resource :user, :as => 'account'  # a convenience route
  match 'user/edit' => "users#edit", :as => :edit_user
  match 'signup' => 'users#new', :as => :signup
  match 'user/show/:user_id' => "users#show", :as => :show_user
  match 'user/edit_password' => "users#edit_password", :as => :edit_password
  match 'user/edit_bio' => "users#edit_about", :as => :edit_about
  match 'user/edit_skill' => "users#edit_skill", :as => :edit_skill

  

  match 'portfolio/upload' => "portfolio#upload", :as => :portfolio_upload
  match 'portfolio/save' => "portfolio#upload_save", :as => :portfolio_upload_save
  match 'portfolio/how_to' => "portfolio#how_to_use", :as => :portfolio_how_to
  match 'portfolio/:portfolio_id/upload_detail_save' => 'portfolio#upload_detail', :as => :portfolio_upload_detail
  match 'portfolio/:portfolio_id/save_detail' => "portfolio#upload_detail_save", :as => :portfolio_upload_save_detail
  match 'portfolio/:portfolio_id/destroy' => "portfolio#destroy", :as => :portfolio_destroy
  match 'portfolio/:portfolio_id/show/:user_id' => "portfolio#show", :as => :portfolio_show
  match 'portfolio/feed' => "portfolio#feed", :as => :portfolio_feed
  match 'portfolio/feed_file' => "portfolio#feed_file", :as => :portfolio_feed_file
  match 'portfolio/multi_delete_port' => "portfolio#multi_delete_port", :as => :portfolio_multi_delete_port

  match 'admin/new_user' => "admin#new_user", :as => :admin_new_user
  match 'admin/create_user' => "admin#create_user", :as => :admin_create_user
  match 'admin/manage_portfolio' => "admin#manage_portfolio", :as => :admin_manage_portfolio
  match 'admin' => "admin#index", :as => :admin_index

  match 'messages/:user_id/compose' => "messages#compose", :as => :message_compose
  match 'messages/:user_id/sent' => "messages#sent", :as => :message_sent
  match 'messages/:user_id/compose_submit' => "messages#compose_submit", :as => :messages_compose_submit
  match 'messages/:user_id/show/:receipt_id' => "messages#show", :as => :message_show
  match 'messages/:user_id/inbox' => "messages#index", :as => :message_index

  match 'news/activity' => "news#activity", :as => :news_activity
  match 'news/contest' => "news#contest", :as => :news_contest
  match 'news/job' => "news#job", :as => :news_job



  root :to => 'user_sessions#new'
  
end
