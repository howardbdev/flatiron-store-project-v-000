class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :carts
  has_many :orders, through: :carts

  def reset_cart
    self.current_cart_id = nil
  end

  def current_cart
    Cart.find_by(id: self.current_cart_id)
  end

end
