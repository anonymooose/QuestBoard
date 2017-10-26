class EventsController < ApplicationController
  require 'pry-byebug'

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
    @games = Game.all
    @event = Event.new
  end

  def create
    params = {
      title: event_params[:title],
      description: event_params[:description],
      game: Game.find(event_params[:game]),
      datetime: event_params.values.last(5).join.to_time,
      host: current_user.host,
      address: event_params[:address]
    }
    binding.pry
    @event = Event.create(params)
    if @event.save
      flash[:notice] = "Event successfully listed!"
      redirect_to event_path(@event)
    else
      flash[:alert] = "Invalid information."
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
    if @event.owner != current_user.host
      flash[:alert] = "You don't own this event."
      redirect_to root_path
    end
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    if @event.save
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def delete
    @event = Event.find(params[:id])
    @event.destroy
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :game, :address, :datetime)
  end

end
