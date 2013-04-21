# encoding: utf-8
module SessionsHelper

  def sign_in(user, remember_me = nil)
    cookies[:remember_token] = { value: user.remember_token, expires: remember_me ? 1.year.from_now : nil }
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def authenticate
    deny_access unless signed_in?
  end

  def deny_access
    store_location
    redirect_to login_path
  end

  def redirect_back_or(default, notice)
    redirect_to(session[:return_to] || default, notice)
    clear_return_to
  end

  private

    def store_location
      session[:return_to] = request.fullpath
    end

    def clear_return_to
      session[:return_to] = nil
    end

end
