class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def thanks
  end

  def index
  end

  def show
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @order.save
    redirect_to orders_comfirm_path
  end

  def comfirm
  end

  private

  def order_params
   params.require(:order).permit(:name, :postal_code, :address, :price, :payment_method)
  end

end
