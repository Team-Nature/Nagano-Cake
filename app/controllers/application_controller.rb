class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # カスタマーは商品一覧へ遷移
  # カスタマーでない場合は管理者トップへ遷移

    def after_sign_in_path_for(resource)
      if customer_signed_in?
        unless current_customer.is_active?
          @customer = current_customer
          session.clear
          flash.notice = "退会済みでございます。"
          new_customer_session_path
        else
          items_path
        end
      else
        admin_top_path
      end
    end

    def after_sign_out_path_for(resource_or_scope)
      if admin_signed_in?
       new_admin_session_path
      else
       root_path
      end

    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :postcode, :address, :tel])

  		devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
    end

    def delete_session
      if session[:how_to_pay].present?
        session.delete(:how_to_pay)
      end
      if session[:deliver_postcode].present?
        session.delete(:deliver_postcode)
      end
      if session[:delviver_address].present?
        session.delete(:deliver_address)
      end
      if session[:deliver_name].present?
        session.delete(:deliver_name)
      end
      if session[:addresses].present?
        session.delete(:addresses)
      end
    end
    
    def delete_keyword_session
      if session[:keyword].present?
        session.delete(:keyword)
      end
    end
end
