class SurveysController < ApplicationController
  def show
    user_surveys = current_user.surveys.select(:player_id)
    user_players = current_user.players.select(:id)
    user_surveys.each do |survey|
      @survey = survey if user_players.include?(survey.player_id)
    end
    @event = Event.find(params[:event_id])
  end

  def update
    @survey = Survey.find(:id)
    if @survey.save
      session[:return_to] ||= request.referer
    else
      redirect_to :show
    end
  end

  private
  def survey_params
    params.require(:survey).permit(:vote_id)
  end
en
