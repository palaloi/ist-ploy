
class UserSessionsController < ApplicationController
	before_filter :require_user,  :only => :destroy

  def new
    @title = "Login"
    @user_session = UserSession.new
  end

  def create
    @title = "Login"
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful!"
      if current_user.user_type and current_user.user_type.name == "Admin"
        redirect_to admin_index_url
      else 
        redirect_back_or_default show_user_url(@current_user)
      end
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default new_user_session_url
  end
end
