# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:index]
  before_action :initialize_cart
  before_action :set_cart
  include Pundit
  before_action :set_current_user

  private

  def set_current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end

  helper_method :current_user_role

  def current_user_role
    current_user&.role
  end

  def set_cart
    @render_cart = true
  end

  def initialize_cart
    @cart ||= Cart.find_by(id: session[:cart_id])

    return unless @cart.nil?

    @cart = Cart.create
    session[:cart_id] = @cart.id
  end
end
