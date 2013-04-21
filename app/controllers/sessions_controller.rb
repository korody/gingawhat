# encoding:   utf-8
class SessionsController < ApplicationController
  
  def new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    user = User.find_by_email(params[:email])
    respond_to do |format|
      if user && user.authenticate(params[:password])
        sign_in user, params[:remember_me]
        format.html { redirect_to root_path }
        format.js
      else
        flash.now[:error] = "Ah, não! Tem algo errado nessa combinação. Tenta de novo!"
        format.html { render 'new' }
        format.js
      end
    end
  end

  def destroy
    sign_out
    redirect_to root_path, notice: "Que a ginga esteja com você!"
  end

end
