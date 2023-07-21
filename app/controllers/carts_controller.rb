class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :pay_bill, :invoice]

  def show
    @cart_items = current_user.cart.cart_items.includes(:product)
    @total_amount = @cart_items.sum { |cart_item| cart_item.price.to_i * cart_item.quantity }
  end
  
  def pay_bill
    @cart_items = current_user.cart.cart_items.includes(:product)
    @total_amount = @cart_items.sum { |cart_item| cart_item.price.to_i * cart_item.quantity }
  
    # Apply the discount logic here (you can customize this logic based on your discount model)
    discount_code = params[:discount_code]
    discount = Discount.find_by(code: discount_code)
  
    if discount
      @cart_items.each do |cart_item|
        price = cart_item.price.to_i
        discounted_price = price * (1 - (discount.discount_percentage / 100.0))
        cart_item.price = discounted_price
        cart_item.save
      end
    end
  
    # Process payment logic here
    # ...
  
    # Create an order and associate it with the user's cart
    @order = Order.create(user: current_user, total_amount: @total_amount)
  
    # Associate the cart items with the order
    @order.order_items = @cart_items.map do |cart_item|
      OrderItem.new(product: cart_item.product, quantity: cart_item.quantity, price: cart_item.price)
    end
  
    # Remove the cart items after successful payment
    @cart_items.destroy_all
  
    # Redirect to the invoice page with the discounted total amount
    redirect_to invoice_path(order_id: @order.id), notice: 'Payment successful. Thank you!'
  end
  
  def invoice
    @order = Order.find(params[:order_id])
    @order_items = @order.order_items
    @user = @order.user
    @total_amount = @order.total_amount # Use the total_amount from the order, which already considers the discount
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
