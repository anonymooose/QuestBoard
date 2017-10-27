class SurveysController < ApplicationController
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
      flash[:notice] = "Thanks for answering! Here's 5 coins!"
    else
      flash[:notice] = "Thanks for being honest! Here's 1 coin!"
    end
    redirect_to user_path(@survey.user)
  end

  private
  def survey_params
    params.require(:survey).permit(:vote, :attended)
  end
end
