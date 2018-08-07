class EventsController < ApplicationController
  include ApplicationHelper

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create

    if !logged_in?
      redirect_to root_path
    end

    @event = Event.create(event_params)
    @event.user_id = current_user.id
    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def show
    @event = Event.find_by_id(params[:id])
    if !logged_in?
      redirect_to root_path
    elsif !owner?
      redirect_to events_path
    end
  end

  def destroy
  end


  def event_params
    params.require(:event).permit(:name, :date, :time, :location, :cost, :description, :user_id)
  end
end
