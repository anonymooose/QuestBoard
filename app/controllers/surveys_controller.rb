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
      determine_change!
      flash[:notice] = "Thanks for answering! Here's #{@survey.event.coins} coins and #{@survey.event.experience} xp!"
    else
      current_user.coins += 1
      flash[:notice] = "Thanks for being honest! Here's 1 coin!"
    end
    redirect_to root_path
  end

  private
  def survey_params
    params.require(:survey).permit(:vote, :attended)
  end

  def determine_change!
    base = current_user
    #treat all answered surveys as attended events
    case base.surveys.length
    when 1 then add_achievement(1)
    when 5 then add_achievement(2)
    end
    case base.host.events.where('datetime < ?', Time.now).length
    when 1 then add_achievement(3)
    when 5 then add_achievement(4)
    end
    if level_up?(current_user.level)
      case current_user.level + 1
      when 2 then add_achievement(5)
      when 5 then add_achievement(6)
      end
    end
    add_event_rewards
    current_user.save
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

  def add_achievement(id)
    current_user.achievements << Achievement.find(id)
  end
end
