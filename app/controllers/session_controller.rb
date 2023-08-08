class SessionsController < ApplicationController

    def create
        user = User.find_by(email: params[:email])
        
        if user && user.authenticate(params[:password])
            session[:id] = user.id
            redirect_to root_path, notice: "Logged in Successfully"
        else
            flash.now[:alert] = "Invalid email or password"
            render new
        end
    end

    def logout
        user = User.find_by(email: params[:email])

        session[:user_id] = nil
        redirect_to root_path , notice: "Logged out Successfully"
    end

end