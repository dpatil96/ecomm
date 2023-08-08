# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :sign_up_params, only: [:create]
    before_action :account_update_params, only: [:update]

    def new
      puts "\n\n...I'm in your local...\n\n"
      build_resource({})
      resource.build_profile
      respond_with resource
    end
    # def get_user
    #   return user = current_user
      
    # end

    def create
      super do |resource|
        # Custom logic after successful registration
        # For example, you can store the user ID in the session
        session[:user_id] = resource.id
      end
    end

    def users_list

      authorize :manager, :users_list?


      @users = User.includes(:order_items)
      @order_items = OrderItem.order(created_at: :desc)
      @cart_items = CartItem.all
    end

    private

    def sign_up_params
      devise_parameter_sanitizer.sanitize(:sign_up)
      params.require(:user).permit(:email, :password, :password_confirmation, :role, :current_password)
    end

    def account_update_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role, :current_password)
    end

    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [profile_attributes: [:name]])
    end
  end
end
