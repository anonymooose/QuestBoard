class SurveysController < ApplicationController
  def show
    @survey = Survey.find(params[:id])
    @event = Event.find(params[:event_id])
  end

  def update
    @survey = Survey.find(params[:id])
    binding.pry
    attendance = survey_params[:attended] == 'true'
    attendance ? @survey.vote = Player.find(survey_params[:vote].to_i) : @survey.vote = 0
    if attendance
      flash[:notice] = "Thanks for answering! Here's 5 coins!"
    else
      flash[:notice] = "Thanks for being honest! Here's 1 coin!"
    end
    binding.pry
    redirect_to user_path(@survey.user)
  end

  private
  def survey_params
    params.require(:survey).permit(:vote, :attended)
  end
end
