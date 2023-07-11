# app/controllers/carts_controller.rb
class CartsController < ApplicationController
    def show
      @cart = current_user.cart
      @cart_items = @cart.cart_items.includes(:product) if @cart.present?
    end
  end
  