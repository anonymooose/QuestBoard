class SurveysController < ApplicationController
  before_action :authenticate_user!
  def index
    @surveys = current_user.surveys!
  end

  def show
    @survey = Survey.find(params[:id])
    @event = Event.find(params[:event_id])
    unless @survey.attended
      flash[:alert] = "The host (#{@event.host.user.username}) said you did not attend. If this is an error please contact an admin."
    end
  end

  def update
    @survey = Survey.find(params[:id])
    @event = @survey.event
    if current_user.host != @event.host
      attendance = survey_params[:attended] == 'true'
      attendance ? @survey.vote = Player.find(survey_params[:vote].to_i) : @survey.vote = 0
      if attendance
        determine_change!
        flash[:notice] = "Thanks for answering! Here's #{@event.coins} coins and #{@event.experience} xp!"
      else
        current_user.coins += 1
        current_user.players.where('event_id = ?', @event.id)[0].destroy
        error_check!
        flash[:notice] = "Thanks for being honest! Here's 1 coin!"
      end
    else
      @survey.vote = Player.find(survey_params[:host_win].to_i)
      @event.update(win:@survey.vote.user)
      flash[:notice] = "Thanks for hosting. Here's #{@event.coins} coins and #{@event.experience} xp!"
    end
    session[:return_to] ||= request.referer
  end

  private
  def survey_params
    if current_user.host == @survey.event.host
      params.require(:survey).permit(:vote, :attended, :host_win, :host_attendance)
    else
      params.require(:survey).permit(:vote, :attended)
    end
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
  end

  def level_up?(initial_level)
    new_level = initial_level + (@survey.event.experience)/100
    return true if initial_level.floor < new_level.floor
    return false
  end

  def error_check!
    @survey.event.win = nil if @survey.event.win == current_user?
  end

  def add_event_rewards
    current_user.update(level:current_user.level + ((@survey.event.experience)/100.0))
    current_user.update(coins:current_user.coins + @survey.event.coins)
  end

  def add_achievement(id)
    current_user.achievements << Achievement.find(id)
    current_user.save
  end
end
