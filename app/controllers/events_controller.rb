class EventsController < ApplicationController

  def index
     @events = Event.where('datetime > ?', Time.now)

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
      game: Game.where(name: event_params[:game]).first,
      datetime: event_params.values.last(5).join.to_time,
      host: current_user.host,
      address: event_params[:address],
      coins: 10,
      experience: 100
    }
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
    @games = Game.all
    @event = Event.find(params[:id])
    @game = @event.game.name
    if @event.host != current_user.host
      flash[:alert] = "You don't own this event."
      redirect_to root_path
    end
  end

  def update
    @event = Event.find(params[:id])
    eparams = {
      title: event_params[:title],
      description: event_params[:description],
      game: Game.where(name: event_params[:game]).first,
      datetime: event_params.values.last(5).join.to_time,
      host: current_user.host,
      address: event_params[:address],
      coins: 10,
      experience: 100
    }

    @event.update(eparams)
    if @event.save
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if (@event.datetime + 86400) < Time.now
      flash[:alert] = "This event has been over for a while, it is no longer available to delete."
      redirect_to root_path
    elsif @event.host != current_user.host
      redirect_to root_path
    else
      @event.destroy
      flash[:notice] = "Event deleted."
      redirect_to root_path
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :game, :address, :datetime)
  end

end
