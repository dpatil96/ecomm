# app/controllers/cart_items_controller.rb

class CartItemsController < ApplicationController
    
  before_action :set_cart
 
  # def create
    #   @product = Product.find(params[:product_id])
    #   @cart = current_user.cart || current_user.create_cart
  
    #   @cart_item = @cart.cart_items.build(product: @product, quantity: 1)
  
    #   if @cart_item.save
    #     redirect_to cart_path, notice: 'Product added to cart successfully.'
    #   else
    #     redirect_to @product, alert: 'Failed to add product to cart.'
    #   end
    # end
    
    def create
      @product = Product.find(params[:product_id])
      @cart_item = @cart.cart_items.find_by(product_id: @product.id)
    
      if @cart_item.present?
        @cart_item.quantity += params[:quantity].to_i
      else
        @cart_item = @cart.cart_items.build(product_id: @product.id, quantity: params[:quantity])
      end
    
      if @cart_item.save
        redirect_to @product, notice: 'Product added to cart.'
      else
        redirect_to @product, alert: 'Failed to add product to cart.'
      end
    end

    private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
    
    
  end
  