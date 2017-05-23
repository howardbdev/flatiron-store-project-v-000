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

    line_item = @cart.line_items.find_by(item_id: params[:item_id] )

    if line_item
      line_item.quantity += 1
      line_item.save
    else
      @cart.line_items.create(item_id: params[:item_id])
    end

    redirect_to cart_path(@cart)
  end

end
