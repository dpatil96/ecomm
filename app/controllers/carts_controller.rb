# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_cart, only: %i[show pay_bill invoice download_pdf]

  def show
    @cart_items = current_user.cart.cart_items.includes(:product)
    return unless @cart.cart_items.present?

    @cart.status = 'Not Paid'
    @cart.total_amount = @cart_items.sum { |cart_item| cart_item.price.to_i * cart_item.quantity }
    @cart.total_quantity = @cart_items.sum(:quantity)
    @cart.save
  end

  def pay_bill
    @cart_items = current_user.cart.cart_items.includes(:product)
    # @cart.total_amount = @cart_items.sum { |cart_item| cart_item.price.to_i * cart_item.quantity }
    # @cart.save
    discount_instance = Discount::Discount.new
    final_amount = discount_instance.apply_discount
    total_discount = @cart.total_amount - final_amount
    # Create an order and associate it with the user's cart
    @order = Order.create(user: current_user, total_amount: final_amount, order_date: Date.current, order_status: "Paid", discount_applied: total_discount)

    # Associate the cart items with the order
    @order.order_items = @cart_items.map do |cart_item|
      OrderItem.new(product: cart_item.product, quantity: cart_item.quantity, price: cart_item.price,
                    invoice_status: 'Paid', invoice_date: Date.current)
    end

    # Remove the cart items after successful payment
    @cart_items.destroy_all

    # Redirect to the invoice page with the discounted total amount
    redirect_to invoice_path(order_id: @order.id), notice: 'Payment successful. Thank you!'
  end

  def invoice
    @cart = current_user.cart
    @cart.status = 'Paid'
    @order = Order.find(params[:order_id])
    @order_items = @order.order_items
    @user = @order.user
    @status = @cart
    @cart_items = current_user.cart.cart_items.includes(:product)
    @total_amount = @cart_items.sum { |cart_item| cart_item.price.to_i * cart_item.quantity }
    # @total_amount = @order.total_amount # Use the total_amount from the order, which already considers the discount
  end

  def download_pdf
    pdf = Prawn::Document.new
    @user = current_user
    # pdf.text 'Hello World'
    # send_data(pdf.render,filename:'hello.pdf',type: 'application/pdf')
    @order = Order.find(params[:order_id])

    if @order
      # Fetch order items related to the order
      @order_items = @order.order_items.includes(:product)

      # Now you can use @order_items to access the details for PDF generation or any other purpose.
    else
      # Handle the case when the order doesn't exist
      redirect_to invoice_path, alert: 'Order not found'
    end

    pdf.text 'INVOICE ', size: 26, align: :center

    pdf.move_down 20

    customer_info = [
      ['Customer name:', @user.profile.name],
      # ['Order date:', @order_items.invoice_date],
      ['Address:', @user.profile.address]
    ]

    product_details = []

    @order_items.each do |order_item|
      product_details << [
        ['Product name:', order_item.product.name],
        ['Product price:', order_item.product.price],
        ['Product quantity:', order_item.quantity]
      ]
    end

    pdf.move_down 20
    pdf.move_down 10

    pdf.bounding_box([pdf.bounds.left, pdf.bounds.top - 50], width: pdf.bounds.width) do
      customer_info.each do |info|
        pdf.text info.join(' '), size: 12
        pdf.move_down 5
      end

      pdf.move_down 20

      pdf.text 'Product Details', size: 18

      pdf.move_down 10

      product_details.each do |detail|
        pdf.text detail.join(' '), size: 12

        pdf.move_down 5
      end
    end

    pdf.text "Total price: #{@order.total_amount}", size: 12

    pdf.text "Discounted price: #{@order.discount_applied}", size: 12

    pdf.text "Payment status: #{@order.order_status}", size: 12

    pdf.move_down 50

    pdf.move_down 40

    pdf_data = pdf.render
    send_data(pdf_data, filename: "#{params[:order_id]}_invoice.pdf", type: 'application/pdf')
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
