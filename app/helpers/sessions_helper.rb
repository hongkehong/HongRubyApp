module SessionsHelper

  def sign_in(user)
    #user.remember_me!
   
   ###OR Just# YES!
   ###this session is not the session_controller (a bit confusing)
   ###session is for this browser 
   ###-- server connection only (has a particular id for this sesssion)!
    session[:cur] = user
    
    #cookies[:remember_token] = { :value   => user.remember_token,
    #                             :expires => 20.years.from_now.utc }
    #this will set cookies data in the browser!
    @current_user = user
  end
  def current_user
    #return @current_user ||= user_from_remember_token
    return @current_user ||= session[:cur]
  end
  def user_from_remember_token
    remember_token = cookies[:remember_token]
    User.find_by_remember_token(remember_token) unless remember_token.nil?
  end
  def signed_in?
    !current_user.nil?
  end
  def deny_access
    store_location
    flash[:notice] = "Please sign in to access this page."
    redirect_to signin_path
  end
  def store_location
    session[:return_to] = request.request_uri
  end
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end
  def clear_return_to
    session[:return_to] = nil
  end
  def current_user?(user)
    user == current_user
  end
  def authenticate
    deny_access unless signed_in?
  end
end

