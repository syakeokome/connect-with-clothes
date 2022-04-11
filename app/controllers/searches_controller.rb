class SearchesController < ApplicationController
  before_action :authenticate_user!
  def search
    @range = params[:range]
    if @range == "ユーザー名"
      @users = User.looks(params[:search], params[:word])
    elsif @range == "投稿名"
      @items = Item.looks(params[:search], params[:word])
    else
      @tags = Tag.looks(params[:search], params[:word]).ids
      @items = Item.where(id: ItemTag.where(tag_id: @tags).pluck('item_id'))
    end
  end


end
