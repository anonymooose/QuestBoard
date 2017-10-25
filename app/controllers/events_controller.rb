class EventsController < ApplicationController

  def index
     @events = Event.all
    if params[:search_loc] != "" && params[:search_date] != ""
      @location = params[:search_loc]
      @datetime = Date.strptime(params[:search_date], "%m/%d/%Y")
      @unsorted_events = Event.by_distance(:origin => "#{@location}")
      @events = []
      for event in @unsorted_events
        if event.datetime > @datetime
          @events << event
        end
      end
    elsif params[:search_loc] != ""
      @location = params[:search_loc]
      @events = Event.by_distance(:origin => "#{@location}")
    elsif params[:search_date] != ""
      @datetime = Date.strptime(params[:search_date], "%m/%d/%Y")
      @events = []
      Event.all.each do |event|
        if event.datetime > @datetime
          @events << event
        end
      end
    else
      @events = Event.all.order("created_at DESC")
    end
  end

  def show
    @event = Event.find(params[:id])
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
