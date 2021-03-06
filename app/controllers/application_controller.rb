class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def home
    if !set_user
      render :layout => "home"
    else
      redirect_to events_path
    end
  end

private

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def set_user
    @user = User.find_by_id(session[:user_id])
  end

  def logged_in?
    if !current_user #!session[:user_id]
      flash[:danger] = 'Woops! Please login or sign  up first'
      redirect_to root_path
    end
      true
  end

  def authenticated?(user)
    user.authenticate(params[:user][:password])
  end

  def owner?
    set_event && set_event.user_id == set_user.id
  end

  def set_event
    @event = Event.find_by_id(params[:event_id]) || Event.find_by_id(params[:id])
  end

end
