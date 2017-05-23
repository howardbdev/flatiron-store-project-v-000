class LineItemsController < ApplicationController

  def create
    if current_user.current_cart_id.nil?
      @cart = Cart.new
      @cart.user_id = current_user.id
      @cart.save
      current_user.update(current_cart_id: @cart.id)
    else
      @cart = Cart.find_by(id: current_user.current_cart_id)
    end
    @cart.line_items.create(item_id: params[:item_id])
    redirect_to cart_path(@cart)
  end

end
