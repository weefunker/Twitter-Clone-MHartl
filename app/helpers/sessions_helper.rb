module SessionsHelper

    # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end


  def current_user?(user)
    user == current_user
  end


  # Returns the current logged-in user (if any).
  def current_user
    # Check for not nil user_id [session]
    if session[:user_id]
      # If user does not exist create one by the session if they have still got session cookie
      @current_user ||= User.find_by(id: session[:user_id])
      # Elseif the user has a permanent signed cookie 
    elsif cookies.signed[:user_id]
      # Find the user id of the cookie
      user = User.find_by(id: cookies.signed[:user_id])
      # In either case being true proceed to log_in the user and set the current user
      if user && user.authenticated?(:remember, cookies[:remember_token])
        # The line above uses our own authenticated? method. Takes optional paramaters using metaprogramming 
        log_in user 
        @current_user = user 
      end
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  def log_out 
    session.delete(:user_id)
    @current_user = nil 
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id 
    cookies.permanent[:remember_token] = user.remember_token
  end


end

