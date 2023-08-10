# frozen_string_literal: true

# app/controllers/discounts_controller.rb
class DiscountsController < ApplicationController
  before_action :authenticate_user! # Use your authentication method
  before_action :set_discount, only: %i[update destroy]
  # after_action :verify_authorized, except: [:index]

  def index
    @discounts = Discount.all
  end

  def new
    @discount = Discount.new
    # authorize @discount
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def edit
    @discount = Discount.find(params[:id])
    # authorize @discount
  rescue ActiveRecord::RecordNotFound
    @discount = Discount.new # Initialize a new Discount instance for new discounts
  end

  def create
    @discount = Discount.new(discount_params)
    # authorize @discount

    if @discount.save
      redirect_to discounts_path, notice: 'Discount created successfully.'
    else
      render :index
    end
  end

  def update
    if @discount.update(discount_params)
      redirect_to discounts_path, notice: 'Discount updated successfully.'
    else
      render :index
    end
  end

  def destroy
    @discount.destroy
    redirect_to discounts_path, notice: 'Discount deleted successfully.'
  end

  private

  def set_discount
    @discount = Discount.find(params[:id])
    # authorize @discount
  end

  def discount_params
    params.require(:discount).permit(:name, :code, :discount_percentage, :discount_limit)
  end
end
