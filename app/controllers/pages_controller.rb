class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  before_action :user_surveys

  def home
    @games = Game.all
    @events = Event.all.order(created_at: :desc).first(3)
  end

  def about
  end

  private
  def user_surveys
    current_user.surveys! unless current_user.nil?
  end
end
