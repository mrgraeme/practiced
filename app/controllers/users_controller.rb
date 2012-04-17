class UsersController < ApplicationController
 
 
 def index
   @users = User.all
 end
 
 
  def new
    @title = "Sign up"
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

end
