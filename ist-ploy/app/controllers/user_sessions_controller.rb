
class UserSessionsController < ApplicationController
	before_filter :require_user,  :only => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful!"
      if current_user.user_type.name == "Admin"
        redirect_to admin_index_path(@current_user.id)
      else 
        redirect_back_or_default account_url(@current_user)
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
