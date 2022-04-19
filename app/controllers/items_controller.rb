class ItemsController < ApplicationController

before_action :correct_item,   only: [:edit, :update]

  def index
    @items =  Item.all.where(is_active: true)
  end

  def new
    @item = Item.new

    #@item = current_user.items.new(item_params)
    #@item.save

  end

  def edit
    @item = Item.find(params[:id])
    @tags = @item.tags.pluck(:name).join(',')
  end

  def show
    #@item = Item.new
    @item = Item.find(params[:id])
    #@comment = Comment.new
    # コメント用のコード
    #@post_comments = @item.comments

    # タグ用のコード
    @tags = @item.tags.pluck(:name).join(',')

    # 閲覧数表示
    #impressionist(@item, nil, :unique => ["session_hash"])
    @comment = Comment.new
    @user = @item.user
  end

  def create
    @item = current_user.items.new(item_params)
    tags = params[:item][:tag].split(',')
    if @item.save
      @item.save_tags(tags)
      redirect_to items_complete_path
    else
      render :new
    end
  end

  def update
    @item = Item.find(params[:id])
    #:postはpostで投稿されてきた際にパラメーターとして飛ばされ、その中の[:tag_id]を取得して、splitで,区切りにしている
    tags = params[:item][:tag].split(',')
    if @item.update(item_params)
    #@postをつけることpostモデルの情報を.save_tagsに引き渡してメソッドを走らせることができる
      @item.update_tags(tags)
      redirect_to item_path(@item), success: t('items.edit.edit_success')
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.update(is_active: false)
    redirect_to root_path
  end

  def individual
    @items = Item.all.where(user_id: current_user.id)
  end

  def comfirm
    @item = Item.new(item_params)
    @item.user = current_user
    @tags = params[:item][:tag]
     if @item.invalid? #入力項目に空のものがあれば入力画面に遷移
       render :new
     end
  end

  def exhibit
     @items = Item.all.where(price: 1..999999, user_id: current_user.id)

  end


  private
  def item_params
    params.require(:item).permit(:name, :image, :introduction, :price, :is_active)
  end
  
  def correct_item
      item = Item.find(params[:id])
      if current_user.id != item.user.id
        redirect_to item_path(item.id)
      end
  end

end
