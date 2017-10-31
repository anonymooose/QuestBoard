class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @user.surveys!
    @events = Player.where(user_id:@user.id)
  end

  def history
    @user = User.find(params[:user_id])
    @events = @user.events.where('datetime < ?', Time.now)
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

 def destroy
    @user = User.find(params[:id])
    @user.destroy
 end

  private

  def user_params
    params.require(:user).permit(:email, :username, :description)
  end

end
