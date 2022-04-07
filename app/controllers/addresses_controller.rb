class AddressesController < ApplicationController
  before_action :authenticate_user!

  def index
    @addresses = Address.all.where(user_id: current_user.id)
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.user_id = current_user.id
    @address.save
    redirect_to addresses_path
  end

  def update
     @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end

end
