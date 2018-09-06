module UsersHelper

  def has_events
    @user_events.size > 0
  end

  def has_rsvps
    @user.attending_events.size > 0
  end

end
