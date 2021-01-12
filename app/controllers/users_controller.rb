class UsersController < ApplicationController
  
  #renders signup form
  def new
  end

  #receiving form + create user with form params
  def create
    user = User.new(user_params)
    user.email = user_params[:email].downcase.strip
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
