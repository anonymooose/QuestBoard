class PlayersController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    @event.add_user(current_user)
    flash[:notice] = "You signed up for #{@event.title}! Have fun!!!!!!!"
    redirect_to event_path(@event)
  end

  private
  def player_params
    params.require(:player)
  end
end
