class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :pay_bill, :invoice]

  def show
    @cart_items = current_user.cart.cart_items.includes(:product)
    @total_amount = @cart_items.sum { |cart_item| cart_item.price.to_i * cart_item.quantity }
    if @cart.cart_items.present?
       @cart.status = "Not Paid"
       @cart.save
    end
  end


  def pay_bill()
    @cart_items = current_user.cart.cart_items.includes(:product)
    @total_amount = @cart_items.sum { |cart_item| cart_item.price.to_i * cart_item.quantity }
     
    # Create an order and associate it with the user's cart
    @order = Order.create(user: current_user, total_amount: @total_amount)
  
    # Associate the cart items with the order
    @order.order_items = @cart_items.map do |cart_item|
      OrderItem.new(product: cart_item.product, quantity: cart_item.quantity, price: cart_item.price, invoice_status: 'Paid', invoice_date: Date.current)
    end
  
    # Remove the cart items after successful payment
    @cart_items.destroy_all
  
    # Redirect to the invoice page with the discounted total amount
    redirect_to invoice_path(order_id: @order.id), notice: 'Payment successful. Thank you!'
  end


  # def pay_bill

  #   @cart.pay_bill(current_user)

  # end

  def apply_discount
    coupon_code = params[:discount_code]
    @cart.apply_discount(coupon_code)

    # Save the updated cart after applying the discount
    @cart.save

    # Redirect back to the cart page with a success message
    redirect_to cart_path(@cart), notice: 'Discount applied successfully.'
  end
  
  
  
  
  def invoice()
    @cart = current_user.cart
    @cart.status = "Paid"
    @order = Order.find(params[:order_id])
    @order_items = @order.order_items
    @user = @order.user
    @status = @cart
    @cart_items = current_user.cart.cart_items.includes(:product)
    @total_amount = @cart_items.sum { |cart_item| cart_item.price.to_i * cart_item.quantity }
    # @total_amount = @order.total_amount # Use the total_amount from the order, which already considers the discount
  end


  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
