# encoding: utf-8
class PasswordResetsController < ApplicationController

  def new    
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    flash[:success] = "Enviamos instruções para seu e-mail."
    redirect_to login_path
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      flash[:error] = "Foi passear perdeu o lugar. Peça outra senha."
      redirect_to new_password_reset_path
    elsif @user.update_attributes(params[:user])
      sign_in @user
      flash[:notice] = "Senha alterada."
      redirect_to root_path
    else
      render :edit
    end
  end

end
