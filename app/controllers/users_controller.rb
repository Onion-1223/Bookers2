class UsersController < ApplicationController
  def index 
    @users =User.all
    
  end
  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    is_matching_login_user
    @user = User.find(params[:id])
  end

  def update
    is_matching_login_user
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "profile was successfully updated"
      redirect_to user_path(@user.id)
    else
       flash.now[:notice] = "profile was not successfully updated"
      render :edit
    end
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(@current_user.id)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

 

end
