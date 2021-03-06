class EventsController < ApplicationController
  before_action :logged_in?, only: [:new, :index, :create, :next]
  before_action :set_event, only: [:show, :edit, :update, :destroy, :next]
  before_action :set_user, only: [:new, :create, :edit, :index, :show, :next]
  before_action :authorized_to_edit?, only: [:show, :edit, :update]

  def index
    if !params[:date].blank?
      if params[:date]== 'Today Events'
        @events = Event.all.todays_events
      elsif params[:date] == 'Old Events'
        @events = Event.all.past_events
      else
        @events = Event.all.future_events
      end
    else
      @events = Event.all
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.create(event_params)
    @event.user_id = current_user.id
    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end



  def show
    @rsvps = @event.rsvps
    @user_events = @user.events
    respond_to do |format|
      format.html
      format.json {render :json => @event}
    end
  end

  def edit
  end

  def update
    @event.update(event_params)
    redirect_to event_path(@event)
  end

  def destroy
    @event.delete
    flash[:info] = "Event has been deleted"
    redirect_to events_path
  end


private

  def event_params
    params.require(:event).permit(:name, :date, :time, :location, :cost, :description, :user_id)
  end

  def authorized_to_edit?
    if !logged_in? || !owner?
      flash[:danger] = 'You are not authorized to edit'
      redirect_to events_path
    end
      true
  end

end
