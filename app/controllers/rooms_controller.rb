class RoomsController < ApplicationController
  def index
    room_ids = current_user.room_users.pluck('room_id')
    user_ids = RoomUser.where(room_id: room_ids).pluck('user_id')
    user_ids.delete(current_user.id)
    @users = User.where(id: user_ids)
  end
  def show
    @room = Room.find(params[:id])
    if RoomUser.where(user_id: current_user.id,room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.room_users
    else
      redirect_back(fallback_location: root_path)
    end
    # binding.irb
    # @user = User.find(params[:user_id])
    @user = @room.room_users.where.not(user: current_user).first().user
  end

  def create
    @room = Room.create
    @entry1 = RoomUser.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = RoomUser.create(room_id: @room.id, user_id: params[:user_id])
    # @entry2 = RoomUser.create(params.require(:room_user).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to "/rooms/#{@room.id}"
  end



end
