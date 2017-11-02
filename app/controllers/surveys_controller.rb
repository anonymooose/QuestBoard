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
        message = "Thanks for answering! You earned #{@event.coins} coins and #{@event.experience} xp!"
      else
        current_user.coins += 1
        current_user.players.where('event_id = ?', @event.id)[0].destroy
        error_check!
        message = "Thanks for being honest! Here's 1 coin!"
      end
    else
      survey_params[:host_attendance].drop(1).each do |survey_id|
        Survey.find(survey_id.to_i).update(vote_id: survey_params[:host_win].to_i)
      end
      @survey.host_win = Player.find(survey_params[:host_win].to_i)
      determine_change!
      message = "Thanks for hosting. You earned #{@event.coins} coins and #{@event.experience} xp!"
    end
    flash[:info] = message
    redirect_to surveys_path
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
    if (new_level(current_user.level) <=> 5) >= 0
      batch_add_achievement([5,6], blacklist)
    elsif (new_level(current_user.level) <=> 1) >= 0
      add_achievement(5) unless blacklist.include?(5)
    end
    if current_user.host == @event.host
      hosted_comparator = base.host.events.where('datetime < ?', Time.now).length
      if (hosted_comparator <=> 5) >= 0
        batch_add_achievement([3,4], blacklist)
      elsif (hosted_comparator <=> 1) >= 0
        add_achievement(3) unless blacklist.include?(3)
      end
    else
      attended_comparator = base.events.where('datetime < ?', Time.now).length
      if (attended_comparator <=> 5) >= 0
        batch_add_achievement([1,2], blacklist)
      elsif (attended_comparator <=> 1) >= 0
        add_achievement(1) unless blacklist.include?(1)
      end
    end
    add_event_rewards
  end

  def level_up?(initial_level)
    return true if initial_level.floor < new_level(initial_level).floor
    return false
  end

  def new_level(initial_level)
    return initial_level + (@survey.event.experience)/100.0
  end

  def error_check!
    @survey.event.win = nil if @survey.event.win == current_user?
  end

  def add_event_rewards
    current_user.update(level:current_user.level + ((@survey.event.experience)/100.0))
    current_user.update(coins:current_user.coins + @survey.event.coins)
  end

  def batch_add_achievement(arr, blacklist)
    arr.each do |id|
      add_achievement(id) unless blacklist.include?(id)
    end
  end

  def add_achievement(id)
    current_user.achievements << Achievement.find(id)
    current_user.save
  end
end
