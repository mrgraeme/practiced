class UsersController < ApplicationController
 
 
 def index
   @users = User.all
 end
 
 
  def new
    @title = "Sign up"
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to Practiced!"
      redirect_to @user
    else
      flash[:failure] = "There seems to have been a hiccup!"
          @title = "Sign up"
      render 'new'
    end
  end

end
