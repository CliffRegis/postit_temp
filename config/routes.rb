PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  # resources :posts, except:[:destroy] do
  #   #resources :comments, only:[:create]
  # end
  
  resources :posts, except:[:destroy]  do
    member do
      post 'vote'
    end
    resources :comments, only:[:create]
  end

  resources :comments, only:[:show]  do
    member do
      post 'vote'
    end
  end

  # resources :posts, except:[:destroy]  do
  #     member do
  #     post :votes, only:[:create]
  #   end
  # end

  resources :categories, only:[:new, :create, :show]
  resources :users, except:[:index, :destroy]
  
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

end 
#   get '/register', to: "users#new" 
#   post '/register', to: "users#create" 
#   get '/profile', to: "users#show" 
#   get '/edit_profile', to: "users#edit" 
#   patch '/profile', to: "users#update"