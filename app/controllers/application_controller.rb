class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
  
  # カスタマーは商品一覧へ遷移
  # カスタマーでない場合は管理者トップへ遷移
  
    def after_sign_in_path_for(resource)
      if customer_signed_in?
        items_path
      else
        admin_top_path
      end
    end
    
    def after_sign_out_path_for(resource)
      root_path
    end
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :kana_first_name, :kana_last_name, :email, :postal_code, :residence, :phone_number])

  		devise_parameter_sanitizer.permit(:sign_in, keys: [:email])

    end
  
  
end
