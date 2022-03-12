class UsersController < ApplicationController
  def show
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
