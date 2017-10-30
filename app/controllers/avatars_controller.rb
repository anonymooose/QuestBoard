class AvatarsController < ApplicationController
  before_action :set_current_avatar
  def edit
  end

  def update
    @avatar.update(avatar_params)
    flash[:notice] = "Avatar successfully updated!"
    redirect_to user_path(current_user)
  end

  private
  def set_current_avatar
    @avatar = current_user.avatar
  end

  def avatar_params
    params.require(:avatar).permit(:gender, :hair, :top, :bottom, :shoes)
  end
end
