class EventsController < ApplicationController

  def index
     @events = Event.all

    if params[:search_loc] != "" && params[:search_date] != "" && params[:search_game] != ""
      @location = params[:search_loc]
      @game = Game.where('name ILIKE ?', "%#{params[:search_game]}%")
      @datetime = Date.strptime(params[:search_date], "%m/%d/%Y")
      @unsorted_events = Event.by_distance(:origin => "#{@location}")
      @events = []
      for event in @unsorted_events
        if event.datetime > @datetime && @game.include?(event.game)
          @events << event
        end
      end

    elsif params[:search_loc] != "" && params[:search_date] != ""
      @location = params[:search_loc]
      @datetime = Date.strptime(params[:search_date], "%m/%d/%Y")
      @unsorted_events = Event.by_distance(:origin => "#{@location}")
      @events = []
      for event in @unsorted_events
        if event.datetime > @datetime
          @events << event
        end
      end

    elsif params[:search_loc] != "" && params[:search_game] != ""
      @location = params[:search_loc]
      @game = Game.where('name ILIKE ?', "%#{params[:search_game]}%")
      @unsorted_events = Event.by_distance(:origin => "#{@location}")
      @events = []
      for event in @unsorted_events
        if @game.include?(event.game)
          @events << event
        end
      end

    elsif params[:search_date] != "" && params[:search_game] != ""
      @game = Game.where('name ILIKE ?', "%#{params[:search_game]}%")
      @datetime = Date.strptime(params[:search_date], "%m/%d/%Y")
      @unsorted_events = Event.where(game: @game)
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

    elsif params[:search_game] != ""
      @game = Game.where('name ILIKE ?', "%#{params[:search_game]}%")
      @events = Event.where(game: @game)

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
