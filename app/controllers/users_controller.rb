class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @currentUserEntry=RoomUser.where(user_id: current_user.id)
    @userEntry=RoomUser.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = RoomUser.new
      end
    end
  end

  def mypage
    @user = current_user
  end

  def edit
   @user =  current_user
  end

  def unscribe
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
     redirect_to users_mypage_path
    else
     render :edit
    end
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: false)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :user_image, :email, :name, :self_introduction, :postal_code, :address, :age, :height, :is_active)
  end

end
