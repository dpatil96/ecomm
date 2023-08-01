
module Discount

    class Discount < ApplicationRecord
        def check_max_discount
            
            @discount_on_quantity = Discount.find_by(name: "on_quantity")
            @discount_on_amount = Discount.find_by(name: "on_amount")
            
            @cart.map { |cart| 
                @cart_total_amount = cart.total_amount
                @cart_quantity = cart.total_quantity
            }  
           
            if @cart_total_amount > @discount_on_amount.discount_threshold && @cart_quantity > 2
                @max_discount = (@discount_on_quantity.discount_limit >  @discount_on_amount.discount_limit) ? @discount_on_quantity : @discount_on_amount
                return @max_discount
            else 
                @max_discount =  @cart_total_amount > @discount_on_amount.discount_threshold ?  @discount_on_amount : @discount_on_quantity
                return @max_discount
            end

            
        
        end

        def apply_discount
            @cart = Cart.all
            # @cart_item = CartItem.all
            # @discount = Discount.find_by(discount_percentage: 10)
            # @discount_on_quantity = Discount.find_by(name: "onquantity")
            @cart.map { |cart| 
                @cart_total_amount = cart.total_amount
            }
            @max_discount = check_max_discount
            final = @cart_total_amount - @max_discount.discount_limit
            return final
                   
                
          
        end
    end
end
