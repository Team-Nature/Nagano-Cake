Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers, path: "au"

  namespace :admin do  #管理者ログイン
    resources :order_items, only: [:update]
    devise_for :customers
  end

  scope module: :public do
    root 'homes#top'
  end

  scope module: :public do
    get "/about" => "homes#about", as: "about"
  end

  namespace :admin do
    get '' => 'admins#top', as: "top"
  end

  #顧客
  namespace :admin do
  resources :customers, only: [:show, :edit, :update, :index]
  end

  scope module: :public do
    resource :customers, only: [:show, :edit, :update]
  end

  scope module: :public do
    get 'customers/quit' => 'customers#quit', as: 'quit' #退会画面表示
    patch 'customers/out' => 'customres#out', as: 'out' #退会処理
  end

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
    get 'orders/thanks' => 'orders#thanks', as: 'thanks' #注文完了ページ
    resources :orders, only: [:new, :create, :index, :show]
    post 'orders/log' => 'orders#log', as: 'log' #注文情報表示
  end

#会員ページONLY
  #カート商品
  scope module: :public do
    resources :cart_items, only: [:index, :update, :create, :destroy]
    delete 'cart_items' => 'cart_items#destroy_all' #カート商品を空にする
  end

  #配送先
  scope module: :public do
    resources :deliveries, only: [:index, :create, :destroy, :edit, :update]
  end

  namespace :admin do
    resources :categories, only: [:new, :create, :edit, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

