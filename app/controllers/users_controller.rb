class UsersController < ApplicationController
  
  before_filter :authenticate, only: [:edit, :update]

  def index
    @users = User.filter(params).order('users.created_at ASC').paginate(page: params[:page], per_page: 20)
    @users_by_type = @users.group_by { |u| u.type }
    @cities = City.scoped
    @city = City.find(params[:city]) if params[:city]
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @user = current_user
    respond_to do |format|
      format.html 
      format.js { render 'new' }
    end
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        sign_in @user
        format.html { redirect_back_or @user, notice: "Bem-vindo ao barco!" }
        format.js
      else
        format.html { render 'new' }
        format.js
      end
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = "Salve-se quem puder!"
      redirect_to back: true
    else
      render 'edit'
    end
  end

end
