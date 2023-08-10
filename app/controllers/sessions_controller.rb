# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def logout
    User.find_by(email: params[:email])

    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out Successfully'
  end

  def destroy
    reset_session # Clears the session
  end
end
