# frozen_string_literal: true

module Discount
  class Discount < ApplicationRecord
    # before_save :set_amount_and_quantity

    def check_max_discount
      set_amount_and_quantity

      if @cart_total_amount > @discount_on_amount.discount_threshold && @cart_quantity > 2
        @max_discount = @discount_on_quantity.discount_limit > @discount_on_amount.discount_limit ? @discount_on_quantity : @discount_on_amount
      else
        @max_discount = @cart_total_amount > @discount_on_amount.discount_threshold ? @discount_on_amount : @discount_on_quantity
      end
      @max_discount
    end

    def apply_discount
      set_amount_and_quantity
      @cart = Cart.all

      @cart.map do |cart|
        @cart_total_amount = cart.total_amount
        @cart_quantity = cart.total_quantity
      end

      return @cart_total_amount unless @cart_total_amount > @discount_on_amount.discount_threshold || @cart_quantity > 2

      @max_discount = check_max_discount
      @cart_total_amount - @max_discount.discount_limit
    end

    def set_amount_and_quantity
      @discount_on_quantity = Discount.find_by(name: 'on_quantity')
      @discount_on_amount = Discount.find_by(name: 'on_amount')
    end
  end
end
