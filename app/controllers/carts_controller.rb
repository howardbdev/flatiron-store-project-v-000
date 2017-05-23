class CartsController < ApplicationController

  before_action :validate_user
  before_action :get_cart, only: [:show]

  private

  def validate_user
    redirect_to store_path unless user_signed_in?
  end

  def get_cart
    @cart ||= current_user.current_cart
    redirect_to store_path unless @cart
  end

end
