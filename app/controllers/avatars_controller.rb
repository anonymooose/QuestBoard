class AvatarsController < ApplicationController
  before_action :set_current_avatar
  def edit
  end

  def update
    @avatar.update(params[:avatar])
    flash[:notice] = "Avatar successfully updated!"
    redirect_to user_page(current_user)
  end

  private
  def set_current_avatar
    @avatar = current_user.avatar
  end
end
