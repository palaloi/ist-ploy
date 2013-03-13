
class MessagesController < ApplicationController
	before_filter :require_user
  def index
  	@user = current_user
  	#Paginating received conversations using :page parameter and 9 per page
		# @inboxes = current_user.mailbox.inbox.page(params[:page]).per(9)
		@inboxes = current_user.mailbox.inbox
		@title = "Message"
  end

  def compose
    @user = User.find(params[:user_id])
    @users = User.find(:all,:select=>'login').map(&:login)
    @title =  "Message: Compose"
    @msg_title = params[:msg_title].blank?? "" : params[:msg_title]
    @msg_body = params[:msg_body].blank?? "" : params[:msg_body]
  end
  def compose_submit
    @user = current_user
    title = params[:title]
    body = params[:body]
    puts "params[:to_user].blank? = #{params[:to_user].blank?}"
    to_user = User.find_by_login(params[:to_user]) unless params[:to_user].blank?
    if to_user.nil?
      flash[:error_notice] = "Can not find the user."
      redirect_to :action => :compose, :params => {:msg_title => title, :msg_body => body}
    end
    # @message = Message.new
    # @message.to_user = 
  end

  def sent
  end
end
