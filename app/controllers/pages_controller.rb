class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @games = Game.all
    @events = Event.all.order(created_at: :desc).first(3)
  end
end
