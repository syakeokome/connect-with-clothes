class ItemsController < ApplicationController


  def index
  end

  def new
    @item = Item.new
  end

  def show
  end

  def comfirm
  end

  def complete
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to items_complete_path
  end

  def update
  end

  def destroy
  end

  def individual
  end

  private

  def item_params
    params.require(:item).permit(:name, :image_id, :introduction, :price, :is_active)
  end

end
