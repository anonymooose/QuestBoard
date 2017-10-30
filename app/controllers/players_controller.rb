class PlayersController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    @event.add_user(current_user)
    flash[:notice] = "You signed up for #{@event.title}! Have fun!!!!!!!"
    redirect_to event_path(@event)
  end

  def destroy
    @event = Event.find(params[:event_id])
    unless @event.past?
      @player = @event.players.where("user_id = ?", current_user.id).first
      @player.destroy
      flash[:notice] = "You've successfully left this event."
      redirect_to event_path(@event)
    else
      redirect_to root_path
    end
  end

  private
  def player_params
    params.require(:player)
  end
end
