class EventsController < ApplicationController

  def index
     @events = Event.all
    if params[:search_loc]
      @location = params[:search_loc]
      @events = Event.by_distance(:origin => "#{@location}")
    else
      @events = Event.all.order("created_at DESC")
    end
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

  def event_params

  end

end
