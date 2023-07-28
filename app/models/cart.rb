# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :order_items , through: :cart_items


  # def pay_bill(current_user)
  #   @cart_items = current_user.cart.cart_items.includes(:product)
  #   @total_amount = @cart_items.sum { |cart_item| cart_item.price.to_i * cart_item.quantity }
     
  #   # Create an order and associate it with the user's cart
  #   @order = Order.create(user: current_user, total_amount: @total_amount)
  
  #   # Associate the cart items with the order
  #   @order.order_items = @cart_items.map do |cart_item|
  #     OrderItem.new(product: cart_item.product, quantity: cart_item.quantity, price: cart_item.price)
  #   end
  
  #   # Remove the cart items after successful payment
  #   @cart_items.destroy_all
  
  #   # Redirect to the invoice page with the discounted total amount
  #   redirect_to invoice_path(order_id: @order.id), notice: 'Payment successful. Thank you!'
  # end




end
