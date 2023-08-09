class SessionsController < ApplicationController
    def new
        
    end

    
    def logout
        user = User.find_by(email: params[:email])

        session[:user_id] = nil
        redirect_to root_path , notice: "Logged out Successfully"
    end

    def destroy
        super
        reset_session # Clears the session
      end

end