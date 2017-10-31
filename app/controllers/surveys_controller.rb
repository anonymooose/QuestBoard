class SurveysController < ApplicationController
  before_action :authenticate_user!
  def index
    @surveys = current_user.surveys!
  end

  def show
    @survey = Survey.find(params[:id])
    @event = Event.find(params[:event_id])
    if @survey.vote != nil && @survey.attended
      flash[:alert] = "You've already answered this."
      redirect_to root_path
    elsif @survey.vote != nil
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
      survey_params[:host_attendance].drop(1).each do |survey_id|
        Survey.find(survey_id.to_i).update(vote_id: survey_params[:host_win].to_i)
      end
      @survey.host_win = Player.find(survey_params[:host_win].to_i)
      determine_change!
      flash[:notice] = "Thanks for hosting. Here's #{@event.coins} coins and #{@event.experience} xp!"
    end
    redirect_to surveys
  end

  private
  def survey_params
    if current_user.host == @survey.event.host
      params.require(:survey)
    else
      params.require(:survey).permit(:vote, :attended)
    end
  end

  def determine_change!
    base = current_user
    blacklist = []
    current_user.achievements.each { |ach| blacklist << ach.id }
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
      curr_lev = current_user.level
      if new_level(curr_lev) - curr_lev > 1.0
        if new_level(curr_lev) > 5.0
          add_achievement(5) unless blacklist.include?(5)
          add_achievement(6) unless blacklist.include?(6)
        elsif new_level(curr_lev) + 1 == 2
          add_achievement(5)
        end
      end
    end
    add_event_rewards
  end

  def level_up?(initial_level)
    return true if initial_level.floor < new_level(initial_level).floor
    return false
  end

  def new_level(initial_level)
    return initial_level + (@survey.event.experience)/100
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
