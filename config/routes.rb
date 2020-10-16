Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers

  namespace :admin do  #管理者ログイン
  devise_for :customers
  end

  scope module: :public do
    root 'homes#top'
  end
  
  get 'home/about' => 'homes#about', as: 'about'
  get 'admins' => 'admins#top'

  #顧客
  namespace :admin do
  resources :customers, only: [:show, :edit, :update, :index]
  end

  scope module: :public do
  resources :customers, only: [:show, :edit, :update]
  end
  get 'customers/:id/quit' => 'customers#quit', as: 'quit' #退会画面表示
  patch 'cart_items/:id/out' => 'cart_items#out', as: 'out' #退会処理

  #商品
  namespace :admin do
  resources :items, only: [:index, :show, :new, :create, :edit, :update]
  end

  scope module: :public do
  resources :items, only: [:index, :show]
  end

  #注文
  namespace :admin do
  resources :orders, only: [:index, :show, :update]
  end

  scope module: :public do
  resources :orders, only: [:new, :create, :index, :show]
  end
  post 'orders/log' => 'orders#log', as: 'log' #注文情報表示
  get 'orders/thanks' => 'orders#thanks', as: 'thanks' #注文完了ページ
  patch 'orders/:order_id/order_items/:id' => 'order_items#update' #商品の制作ステータスの更新


#会員ページONLY
  #カート商品
  resources :cart_items, only: [:index, :update, :create, :destroy]
  delete 'cart_items' => 'cart_items#destroy_all' #カート商品を空にする

  #配送先
  resources :deliveries, only: [:index, :create, :destroy, :edit, :update]
  
  namespace :admin do
    resources :categories
  end




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
