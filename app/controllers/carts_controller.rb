class CartsController < ApplicationController


  before_action :validate_user
  before_action :get_current_cart, only: [:show, :checkout]

  def checkout
    @cart.process_cart_submission
    current_user.reset_cart
    redirect_to cart_path(@cart)
  end

  private

  def validate_user
    redirect_to store_path unless user_signed_in?
  end

  def get_current_cart
    @cart = Cart.find_by(id: params[:id])
    if @cart.nil?
      flash[:error] = "Could not locate that cart."
      redirect_to store_path
    end
  end

end
