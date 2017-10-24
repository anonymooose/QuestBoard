class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @events = Player.where(user_id:@user.id)
  end

end
