class ItemsController < ApplicationController


  def index
    @items =  Item.all
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
    @tags = @item.tags.pluck(:name).join(',')
  end

  def show
    @item = Item.find(params[:id])
    #@comment = Comment.new
    # コメント用のコード
    #@post_comments = @post.comments

    # タグ用のコード
    @tags = @item.tags.pluck(:name).join(',')

    # 閲覧数表示
    impressionist(@item, nil, :unique => ["session_hash"])
  end

  def comfirm
  end

  def complete
  end

  def create
    @item = current_user.items.new(item_params)
    tags = params[:item][:tag_id].split(',')
    if @item.save
      redirect_to items_complete_path
      @item.save_tags(tags)
      redirect_to root_path, success: t('items.create.create_success')
    else
      render :new
    end
  end

  def update
    @item = Item.find(params[:id])
    #:postはpostで投稿されてきた際にパラメーターとして飛ばされ、その中の[:tag_id]を取得して、splitで,区切りにしている
    tags = params[:item][:tag_id].split(',')
    if @item.update(item_params)
    #@postをつけることpostモデルの情報を.save_tagsに引き渡してメソッドを走らせることができる
      @item.update_tags(tags)
      redirect_to root_path, success: t('items.edit.edit_success')
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to root_path, success: t('itemss.destroy.destroy_success')
  end

  def individual
  end

  private

  def item_params
    params.require(:item).permit(:name, :image_id, :introduction, :price, :is_active)
  end

end
