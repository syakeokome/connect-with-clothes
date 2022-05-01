class OrdersController < ApplicationController
  def new
    @order = Order.new
    @item = Item.find(params[:item_id])
  end

  def thanks
  end

  def index
    @orders = Order.all.where(user_id: current_user.id)

  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @order.item_id = params[:item_id]
    @order.save
    if @order.save
      @order.item.update_attribute(:order_status, :"購入済み")
      redirect_to item_orders_thanks_path
    else
      redirect_to new_item_order_path
    end
  end

  def comfirm
    @order = Order.new
    @order.payment_method = params[:order][:payment_method]
    @order.item_id = params[:item_id]
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



