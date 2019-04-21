require 'sidekiq/web'
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1 do
    resources :apps do
      resources :chats do
        resources :messages
      end
    end
  end
  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/chat'
end
