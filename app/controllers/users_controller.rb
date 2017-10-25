class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @events = Player.where(user_id:@user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

 def update
    @user = current_user
    @user.update(user_params)
    @user.save
    redirect_to user_path(@user)
 end

 def delete
    @user = User.find(params[:id])
    @user.destroy
 end

  private

  def user_params
    params.require(:user).permit(:email, :username, :description, :login)
  end

end
