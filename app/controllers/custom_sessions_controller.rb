# frozen_string_literal: true

class CustomSessionsController < Devise::SessionsController
  
  def create
    super do |user|
      session[:user_id] = user.id
  end
 
  

  def logout
    User.find_by(email: params[:email])

    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out Successfully'
  end

  def destroy
    reset_session # Clears the session
  end
end
