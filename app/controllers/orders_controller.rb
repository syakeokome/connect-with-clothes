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
    @order = Order.new
    @order.payment_method = params[:order][:payment_method]
    if params[:order_address] == "0"
      @order.postal_code = current_user.postal_code
      @order.address = current_user.address
      @order.name = current_user.name
    elsif params[:order_address] == "1"
      @address = Address.find(params[:order][:registard_address])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    else
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
  end

  private

  def order_params
   params.require(:order).permit(:name, :postal_code, :address, :price, :payment_method)
  end

end
