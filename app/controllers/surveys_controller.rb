class SurveysController < ApplicationController
  before_action :authenticate_user!
  def index
    @surveys = current_user.surveys!
  end

  def show
    @survey = Survey.find(params[:id])
    if @survey.attended
      flash[:alert] = "You've already answered this survey."
      session[:return_to] ||= request.referer
    end
    @event = Event.find(params[:event_id])
  end

  def update
    @survey = Survey.find(params[:id])
    attendance = survey_params[:attended] == 'true'
    attendance ? @survey.vote = Player.find(survey_params[:vote].to_i) : @survey.vote = 0
    if attendance
      determine_change(current_user)
      flash[:notice] = "Thanks for answering! Here's 5 coins!"
    else
      flash[:notice] = "Thanks for being honest! Here's 1 coin!"
    end
    redirect_to root_path
  end

  private
  def survey_params
    params.require(:survey).permit(:vote, :attended)
  end

  def determine_change(initial_user_status)
    base = initial_user_status
    #treat all answered surveys as attended events
    base.surveys.length

  end

  def level_up?(initial_level)
    new_level = initial_level + (@survey.event.experience)/100
    return true if initial_level.floor < new_level.floor
    return false
  end

  def add_event_rewards
    @survey.user.level += (@survey.event.experience)/100.0
    @survey.user.coins += @survey.event.coins
  end
end
